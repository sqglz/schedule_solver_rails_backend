class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :first_name, length: { maximum: 40 }
  validates :last_name, length: { maximum: 80 }
  validates :password, length: { minimum: 10 }

  enum user_role: [ :user, :worker, :manager, :owner, :admin ]

  # validate :password_complexity
  validate :validate_email_format
  validate :responsibility_exists?, if: :will_save_change_to_worker_responsibilities?

  after_create :create_username

  before_save  :ensure_user_role

  has_one :business_user
  has_one :business, through: :business_user

  def role?
    user_role
  end

private

  def responsibility_exists?
    return add_responsibility_error() if !business

    worker_responsibilities.each do |r|
      return true unless !business || Responsibility.where(name: r.capitalize).empty?

      return add_responsibility_error(r)
    end
  end

  def ensure_user_role
    return unless user_role.nil?

    self.user_role = 0
  end

  MESSAGE = 'format is invalid'.freeze
  REGEXP  = /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.freeze

  def validate_email_format
    return unless email.present?

    errors.add(:email, MESSAGE) unless email =~ REGEXP
  end

  def password_complexity
    return if password&.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)

    errors.add :password, 'must include at least one lowercase letter, one uppercase letter, and one digit'
  end

  def create_username
    return if username.present?

    self.username = email.split('@')[0].to_s
    self.save
  end

  def add_responsibility_error(resp_name=nil)
    if resp_name
      errors.add(:worker_responsiblities, "#{resp_name} Responsibility does not exist in database")
    else
      errors.add(:worker_responsiblities, "User does not belong to a business!")
    end
  end
end
