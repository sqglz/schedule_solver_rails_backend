# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
business = Fabricate(:business)

name = %w(Lunch Dinner Morning Double).sample

8.times do |i|
  start = (DateTime.new(2020, 3, i+1) + rand(10..15).hours)
  end_time = start + 3.hours
  shift = Shift.create(business_id: business.id, name: name, start_time: start, end_time: end_time)
  resp = Fabricate(:assignment)
  Fabricate(:shift_assignment, shift: shift, assignment: resp)
end

Fabricate(:manager_with_schedule)
