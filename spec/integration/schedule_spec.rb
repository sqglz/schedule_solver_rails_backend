require 'rails_helper'

RSpec.describe 'Schedule', type: :class  do
  context 'model functionality' do
    describe 'initialization' do
      let(:schedule) { Schedule.new }
      let(:shifts) { Shift.all }
      let(:schedule_with_shifts) { Schedule.new(shifts) }
      # schedules initialize with each day as a class var
      it 'initializes with the days of the week
                as class variables, attr accessible' do
          expect(schedule).to have_attributes(
            :monday => [],
            :tuesday => [],
            :wednesday => [],
            :thursday => [],
            :friday => [],
            :saturday => [],
            :sunday => []
          )
      end
      context 'with Shifts, ShiftAssignments, and Users created' do
        let(:shifts) { Shift.all }
        let!(:load_shifts) { Schedule.new(shifts, default) }

        context "as default schedule" do
          before(:all) do
            shifts = %w(Waiter, Backwaiter, Host/Hostess, Bartender)
            business = Fabricate(:business)

            shifts.each do |shift|
              Assignment.create(name: shift)
            end

            10.times do
              start_time = rand(1.years).seconds.ago
              end_time = (start_time + 2.hours)

              shift = Shift.create!(
                business_id: business.id,
                start_time: start_time,
                end_time: end_time
              )

              (0..rand(0..3)).each do |d|
                n = d + 1
                resp_id = Assignment.find(n).id
                ShiftAssignment.create(
                  shift_id: shift.id,
                  assignment_id: resp_id
                )
              end
            end
          end

          let(:default) { true }

          let(:shift_total_num) do
            return (
              load_shifts.monday.count +
              load_shifts.tuesday.count +
              load_shifts.wednesday.count +
              load_shifts.thursday.count +
              load_shifts.friday.count +
              load_shifts.saturday.count +
              load_shifts.sunday.count
            )
          end

          it 'stores shifts as attr accessibles and adds each to weekday' do
            expect(shifts.count).to eq(10)
            expect(load_shifts.sync_shifts_to_week).to eq( "Shifts successfully synched. Schedule ready" )

            expect(load_shifts.shifts.count).to eq(10)
          end

          it 'each shift stores shift assignments' do
            monday_shifts = load_shifts.monday.map{|s| s.start_day }.uniq[0]
            tuesday_shifts = load_shifts.tuesday.map{|s| s.start_day }.uniq[0]
            wednesday_shifts = load_shifts.wednesday.map{|s| s.start_day }.uniq[0]
            thursday_shifts = load_shifts.thursday.map{|s| s.start_day }.uniq[0]
            friday_shifts = load_shifts.friday.map{|s| s.start_day }.uniq[0]
            saturday_shifts = load_shifts.saturday.map{|s| s.start_day }.uniq[0]
            sunday_shifts = load_shifts.sunday.map{|s| s.start_day }.uniq[0]

            expect(monday_shifts).to eq("Monday").or(eq(nil))
            expect(tuesday_shifts).to eq("Tuesday").or(eq(nil))
            expect(wednesday_shifts).to eq("Wednesday").or(eq(nil))
            expect(thursday_shifts).to eq("Thursday").or(eq(nil))
            expect(friday_shifts).to eq("Friday").or(eq(nil))
            expect(saturday_shifts).to eq("Saturday").or(eq(nil))
            expect(sunday_shifts).to eq("Sunday").or(eq(nil))
          end

          it 'each shift sorts to correct weekday' do
            expect(shift_total_num).to eq(10)
          end
        end
      end
    end
    describe 'something else' do
    end
  end
end
