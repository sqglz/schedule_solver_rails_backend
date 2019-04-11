class ShiftPresenter < SimpleDelegator
  attr_reader :start, :end, :name, :shifts, :start_day, :end_day

  def initialize(shift)
    @name = shift.name
    @start_day = Date::DAYNAMES[shift.start_time.wday]
    @end_day = Date::DAYNAMES[shift.end_time.wday]
    @start = shift.start_time.strftime('%H:%M:%S')
    @end = shift.end_time.strftime('%H:%M:%S')
    @shifts = shift.shifts
  end
end
