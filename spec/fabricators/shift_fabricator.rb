Fabricator(:shift) do
  business
  name       %w(Lunch Dinner Double).sample
  start_time "2019-04-06 14:03:22"
  end_time   "2019-04-06 14:03:22"
  schedule_id nil
end

Fabricator(:shift_with_assignments, from: :shift) do
  after_create do |shift|
    3.times do
      resp = Fabricate(:assignment)
      Fabricate(:shift_assignment, shift: shift, assignment: resp)
    end
  end
end

Shift.all.each do |s|
  ass = Assignment.order('RANDOM()').first
  2.times do
    ShiftAssignment.create(
      shift_id: s.id,
      assignment_id: ass.id
    )
  end
  ass = Assignment.order('RANDOM()').first
  2.times do
    ShiftAssignment.create(
      shift_id: s.id,
      assignment_id: ass.id
    )
  end
end
