Fabricator(:shift) do
  business
  name       Faker::Military.marines_rank
  start_time "2019-04-06 14:03:22"
  end_time   "2019-04-06 14:03:22"
end

Fabricator(:shift_with_assignments, from: :shift) do
  after_create do |shift|
    3.times do
      resp = Fabricate(:assignment)
      Fabricate(:shift_assignment, shift: shift, assignment: resp)
    end
  end
end
