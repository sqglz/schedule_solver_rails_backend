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
  validate     :check_worker_status

  has_one :business_user, dependent: :destroy
  has_one :business, through: :business_user

  def role?
    user_role
  end

private

  def responsibility_exists?
    return add_responsibility_errors() if !business

    no_records = worker_responsibilities.select do |r|
      Assignment.where(name: r.capitalize).empty?
    end

    return no_records.empty? ? true : add_responsibility_errors(no_records)
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

  def add_responsibility_errors(resp_names=nil)
    if resp_names
      resp_names.each do |resp_name|
        self.worker_responsibilities.delete(resp_name)
        errors.add(:worker_responsiblities, "#{resp_name} Assignment does not exist in database")
      end
    else
      errors.add(:worker_responsiblities, "User does not belong to a business!")
    end
  end

  def check_worker_status
    return true unless user_role == 'worker'
    if !employment_start_date
      errors.add(:employment_start_date, "Must include an employment start date for worker!")
    end
  end
end
