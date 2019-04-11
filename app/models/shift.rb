class Shift < ApplicationRecord
  belongs_to :business

  has_many :shift_responsibilities, dependent: :destroy
  has_many :responsibilities, through: :shift_responsibilities

  def shifts
    shift_responsibilities
  end

  def filled?
    !shifts.pluck(:assigned).include?(false)
  end

  def unfilled_assignments
    shifts.where(assigned: false).pluck(:name)
  end

  def assign_shift(user, responsibility, assignment=nil)
    return false unless user.role? == 'worker' || user.role? == 'manager'

    if responsibility
      assignment = shift_responsibilities.find(responsibility.id)
    elsif assignment
      respo = responsibilities.select{|r| r.name == assignment.downcase.capitalize }
      assignment = shift_responsibilities.find_by(responsibility_id: respo.id)
    end

    assignment.user_id = user.id
    assignment.save
    return true
  end
end
