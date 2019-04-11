class Business < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :business_users, dependent: :destroy
  has_many :employees, through: :business_users, source: :user
end
