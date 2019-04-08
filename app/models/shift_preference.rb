class ShiftPreference < ApplicationRecord
  belongs_to :shift
  belongs_to :user

  validates_presence_of :shift, :user

  enum answer: [ :preferred, :available, :unavailable ]
end
