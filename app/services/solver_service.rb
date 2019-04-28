class SolverService
  attr_accessor :employees, :schedule, :shifts

  attr_reader   :assigned_shifts

  JOB_PREFERENCE_ORDER = ['Bartender', 'Waiter', 'Backwaiter'].freeze

  def initialize(schedule, employees)
    @employees = employees.inject({}) do |acc, emp|
      acc[emp] = get_points(emp)
      acc
    end
    @schedule = schedule
    @assigned_shifts = []
    @shifts = schedule.order_shifts
  end

  def call
    shifts.each_with_index do |shift, i|
      shift_assignments = shift.shifts

      shift_assignments.each do |_sas|
        if _sas.assigned
          @assigned_shifts << _sas
        else
          sorted_employees_by_pts = employees
            .sort_by{|_key, value| value}
            .to_h.keys

          i = 0
          employee_undecideds = []
          until i == sorted_employees_by_pts.length do

            employee = sorted_employees_by_pts[i]
            employee_pref = ShiftPreference.find_by(
              shift_id: _sas.shift_id,
              user_id: employee.id
            )&.answer

            if (employee_pref== 'available' || employee_pref == nil) && employee.worker_responsibilities.include?(_sas.name)
              employee_undecideds << employee
            else
              attempt_assign_shift_employee_preference(_sas, employee)
            end
            i += 1
          end

          _sas.assigned? ? @assigned_shifts << _sas : return_notes(_sas, employee_undecideds)

        end
      end
    end
  end

  def get_points(employee)
    (DateTime.now - employee.employment_start_date.to_datetime).to_i
  end

  def attempt_assign_shift_employee_preference(shift_assignment, employee)
    _sas      = ShiftAssignment.find(shift_assignment.id)
    shift     = _sas.shift
    positions = employee.worker_responsibilities

    positions.each do |p|
      return if _sas.assigned? || shift.is_working_shift?(employee)

      shift_pref = ShiftPreference.find_by(
        shift_id: _sas.shift_id,
        user_id: employee.id
      )

      if shift_pref.present? && shift_pref.answer == 'preferred' && p == _sas.name
        _sas.update(user_id: employee.id)
        @employees[employee] -= 20
      else
        next
      end
    end
  end

  def return_notes(sa, employee_undecideds)
    names = employee_undecideds.map{|em| em.first_name + ' ' + em.last_name }.join(', ')
    names.empty? ?
      sa.update(
        notes: "Couldnt find anyone available for shift assignment"
      ) : sa.update(notes: "Try these folks for help: #{names}.")
  end
end
