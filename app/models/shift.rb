class Shift < ApplicationRecord
  belongs_to :business

  has_many :shift_assignments, dependent: :destroy
  has_many :assignments, through: :shift_assignments
  has_many :shift_preferences, dependent: :destroy

  def shifts
    shift_assignments
  end

  def filled?
    !shifts.pluck(:assigned).include?(false)
  end

  def is_working_shift?(employee)
    shifts.pluck(:user_id).include?(employee.id)
  end

  def unfilled_assignments
    shifts.where(assigned: false).pluck(:name)
  end

  def assign_shift(user, responsibility, assignment=nil)
    return false unless user.role? == 'worker' || user.role? == 'manager'

    if responsibility
      assignment = shift_assignments.find(responsibility.id)
    elsif assignment
      respo = assignments.select{|r| r.name == assignment.downcase.capitalize }
      assignment = shift_assignments.find_by(assignment_id: respo.id)
    end

    assignment.user_id = user.id
    assignment.save
    return true
  end
end
