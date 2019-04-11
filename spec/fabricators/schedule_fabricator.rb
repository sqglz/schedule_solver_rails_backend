Fabricator(:schedule) do
  business
  owner_id 1
  default  false
end

Fabricator(:schedule_with_shifts, from: :schedule) do
  after_create do |schedule|
    business = Business.last

    3.times do
      Fabricate(:shift_with_assignments, business: business, schedule_id: schedule.id)
    end
  end
end
