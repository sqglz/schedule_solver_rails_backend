class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :first_name, length: { maximum: 40 }
  validates :last_name, length: { maximum: 80 }
  validates :password, length: { minimum: 10 }

  enum user_role: [ :user, :worker, :manager, :owner, :admin ]

  # validate :password_complexity
  validate :validate_email_format

  after_create :create_username
  before_save  :ensure_user_role

private

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
end
