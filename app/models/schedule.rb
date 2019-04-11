class Schedule < ApplicationRecord
  attr_reader   :default

  attr_accessor :monday, :tuesday, :wednesday,
                :thursday, :friday, :saturday, :sunday

  has_many :shifts

  after_create :associate_shifts

  def associate_shifts
    @monday = []
    @tuesday = []
    @wednesday = []
    @thursday = []
    @friday = []
    @saturday = []
    @sunday = []
    return true if shifts.empty?
    sync_shifts_to_week
  end

  def sync_shifts_to_week(input_shifts=shifts)
    shifts.each do |shift|
      shift.update!(schedule_id: self.id)
      day = Date::DAYNAMES[shift.start_time.wday]
      add_shift_to_day(day, shift)
    end

    return "Shifts successfully synched. Schedule ready"
  end

  def display_full_week
    {
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
      sunday: sunday
    }
  end

  private

    def add_shift_to_day(day, shift)
      shift = ShiftPresenter.new(shift)
      case day
      when "Monday"
        @monday << shift
      when "Tuesday"
        @tuesday << shift
      when "Wednesday"
        @wednesday << shift
      when "Thursday"
        @thursday << shift
      when "Friday"
        @friday << shift
      when "Saturday"
        @saturday << shift
      when "Sunday"
        @sunday << shift
      else
        raise Exception.new("Something went wrong in Schedule creation")
      end
    end
end
