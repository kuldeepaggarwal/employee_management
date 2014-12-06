module EmployeeHelper
  def employee_group_select_options
    Employee.searchable_columns.collect do |column|
      [column.name.titleize, column.name]
    end
  end
end
