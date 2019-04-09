class Schedule
  attr_reader   :default, :shifts

  attr_accessor :monday, :tuesday, :wednesday,
                :thursday, :friday, :saturday, :sunday

  def initialize(shifts=nil, default=false)
    @default = default
    @monday = []
    @tuesday = []
    @wednesday = []
    @thursday = []
    @friday = []
    @saturday = []
    @sunday = []
    @shifts = shifts
    return true unless shifts
    sync_shifts_to_week(shifts)
  end

  def sync_shifts_to_week(shifts=@shifts)
    shifts.each do |shift|
      day = Date::DAYNAMES[shift.start_time.wday]
      add_shift_to_day(day, shift)
    end
    return "Shifts successfully synched. Schedule ready"
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
