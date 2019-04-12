class SolverService
  attr_accessor :employees, :schedule, :shifts

  def initialize(schedule, employees)
    @employees = employees.inject({}) do |acc, emp|
      acc[get_points(emp)] => emp
      acc
    end
    @schedule = schedule
    @shifts = schedule.order_shifts
  end

  def call

    shifts.each_with_index do |shift, i|
      worker_points = employees.sort.reverse
      employee = worker_points[0]
      shift_assignments = shift.shifts
      shift_assignments.each do
        shift_pref = ShiftPreference.where(shift_id: shift.id)
      end
    end
  end

  def get_points(employee)
    (DateTime.now - employee.employment_start_date.to_datetime).to_i
  end
end
