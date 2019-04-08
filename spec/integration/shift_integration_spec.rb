require 'rails_helper'

RSpec.describe 'Shift Integration' do
  context 'Shifts' do
    describe 'shift creation' do
    # Shifts consist of name, start_time, end_time
    end
    describe 'shift associations' do
    # Shifts belong to businesses
    # Shifts have_many :shift_responsibilities..; ..responsibilities
    end
    describe 'shift assignment and signing up' do
      # Only WORKERS or MANAGERS can satisfy a shift_role;
      # Shift roles are assigned by user_id and given boolean 
    end
  end
  context 'Schedules' do
    context 'all schedules' do
      # Manager, Admin, or Owner can create schedules
      # A schedule is a hash with each day of the week as
      # keys, with arrays of shifts for corresponding values

      # Scheduler arrays are sorted by shift start_time
    end
    context 'default schedules' do
    end
  end
end
