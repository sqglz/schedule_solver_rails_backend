class ShiftPresenter
  attr_reader :id, :name, :start_day, :end_day, :start, :end, :shifts, :filled

  def initialize(shift)
    @id        = shift.id
    @name      = shift.name
    @start_day = Date::DAYNAMES[shift.start_time.wday]
    @end_day   = Date::DAYNAMES[shift.end_time.wday]
    @start     = shift.start_time.strftime('%H:%M:%S')
    @end       = shift.end_time.strftime('%H:%M:%S')
    @shifts    = shift.shifts.to_a
    @filled    = shift.filled?
  end
end
