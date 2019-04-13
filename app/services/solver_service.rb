class SolverService
  attr_accessor :employees, :schedule, :shifts

  def initialize(schedule, employees)
    @employees = employees.inject({}) do |acc, emp|
      acc[emp] => get_points(emp)
      acc
    end
    @schedule = schedule
    @shifts = schedule.order_shifts
  end

  def call
    assigned_shifts = []
    shifts.each_with_index do |shift, i|
      shift_assignments = shift.shifts

      shift_assignments.each do |sa|

        worker_points = employees.sort.reverse
        employee = worker_points[0]
        position = employee.worker_responsibilities[0]
        shift_pref = ShiftPreference.find_by(shift_id: shift.id, user_id: employee.id)

        if shift_pref.exists? && shift_pref.answer = preferred && !sa.assigned?
          sa.update(user_id: employee.id)
          assigned_shifts << sa
          @employees[empl] -= 20
        else
          next
        end

      end
    end
  end

  def get_points(employee)
    (DateTime.now - employee.employment_start_date.to_datetime).to_i
  end
end
