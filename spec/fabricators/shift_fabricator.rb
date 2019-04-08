Fabricator(:shift) do
  business
  name       Faker::Military.marines_rank
  start_time "2019-04-06 14:03:22"
  end_time   "2019-04-06 14:03:22"
end

Fabricator(:shift_with_responsibilities, from: :shift) do
  after_create do |shift|
    3.times do
      resp = Fabricate(:responsibility)
      Fabricate(:shift_responsibility, shift: shift, responsibility: resp)
    end
  end
end
