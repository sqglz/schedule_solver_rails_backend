class SolverService
  attr_accessor :employees, :schedule, :shifts

  def initialize(schedule, employees)
    @employees = employees
    @schedule = schedule
    @shifts = schedule.order_shifts
  end

  def call
    emps = employees
    unassigned_shifts = shifts
    unassigned_shifts.each do |s|
    end
  end
end
