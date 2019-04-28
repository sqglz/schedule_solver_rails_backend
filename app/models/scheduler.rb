class Scheduler

  attr_reader   :owner_id, :default, :id, :created_at, :updated_at,
                :day

  attr_accessor :monday, :tuesday, :wednesday,
                :thursday, :friday, :saturday, :sunday, :shifts

  def initialize(schedule, day="Friday")
    @monday     = []
    @tuesday    = []
    @wednesday  = []
    @thursday   = []
    @friday     = []
    @saturday   = []
    @sunday     = []
    @id         = schedule.id
    @created_at = schedule.created_at
    @updated_at = schedule.updated_at
    @owner_id   = schedule.owner_id
    @default    = schedule.default
    @shifts     = nil
    @day        = day
    associate_shifts
  end

  def associate_shifts
    assoc_shifts = Schedule.find(id).shifts

    return true if assoc_shifts.empty?
    sync_shifts_to_week(assoc_shifts)
  end

  def sync_shifts_to_week(assoc_shifts)

    assoc_shifts.each do |shift|
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

  def order_shifts
    days = [friday, saturday, sunday, monday, tuesday, wednesday, thursday]
    case day
    when "Friday"
      sorted_shifts = days.flatten
    end
    @shifts = sorted_shifts
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
        raise Exception.new("Something went wrong in Scheduler creation")
      end
    end

end
