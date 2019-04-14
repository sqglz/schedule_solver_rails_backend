class User < ApplicationRecord
  has_secure_password

  JOB_PREFERENCE_ORDER = ['Bartender', 'Waiter', 'Backwait'].freeze

  validates :email, presence: true, uniqueness: true
  validates :first_name, length: { maximum: 40 }
  validates :last_name, length: { maximum: 80 }
  # length here cant be measured in a validation as password = nil after password digest algorithm is ran
  # validates :password, length: { minimum: 10 }

  enum user_role: [ :user, :worker, :manager, :owner, :admin ]

  # validate :password_complexity
  validate :validate_email_format
  validate :responsibility_exists?, if: :will_save_change_to_worker_responsibilities?


  before_save :order_responsibilities, if: :will_save_change_to_worker_responsibilities?
  before_save :ensure_user_role

  after_create :create_username

  validate     :check_worker_status

  has_one :business_user, dependent: :destroy
  has_one :business, through: :business_user

  has_many :shift_preferences

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

  def order_responsibilities
    ordered_resp = []
    JOB_PREFERENCE_ORDER.each do |jb|
      if worker_responsibilities.include?(jb)
        ordered_resp << jb
      end
    end
    self.worker_responsibilities = ordered_resp
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
        errors.add(:worker_responsibilities, "#{resp_name} Assignment does not exist in database")
      end
    else
      errors.add(:worker_responsibilities, "User does not belong to a business!")
    end
  end

  def check_worker_status
    return true unless user_role == 'worker'
    if !employment_start_date
      errors.add(:employment_start_date, "Must include an employment start date for worker!")
    end
  end
end
