class ShiftAssignment < ApplicationRecord
  belongs_to :shift
  belongs_to :assignment

  validates_presence_of :shift_id
  validates_presence_of :assignment_id

  before_create :validate_no_name

  after_create :assign_name

  before_save :is_shift_filled?

  def shifts
    shift_assignments
  end

private

  def assign_name
    self.name = assignment.name
    self.save
  end

  def is_shift_filled?
    filled = self.user_id ? true : false
    self.assigned = filled
  end

  def validate_no_name
    return true unless name.present?

    errors.add(:name, 'No name required')
    raise ActiveRecord::RecordInvalid.new(self)
  end
end
