class ShiftPreference < ApplicationRecord
  belongs_to :shift
  belongs_to :user

  enum answer: [ :preferred, :available, :unavailable ]
end
