class BusinessUser < ApplicationRecord
  belongs_to :business
  belongs_to :user

  validates_presence_of :user, :business
end
