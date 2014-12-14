class EmployeesController < ApplicationController

  before_filter :load_resource, only: [:destroy, :edit, :update]

  def index
    @employees = Employee.search(params[:q])
                         .grouped_by(params[:group_by])
                         .sort_order(params[:sort], params[:dir])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = 'Employee has been successfully created.'
      redirect_to employees_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @employee.update_attributes(employee_params)
      flash[:success] = 'Employee has been successfully updated.'
      redirect_to employees_path
    else
      render :edit
    end
  end

  def destroy
    if @employee.destroy
      message = 'Employee has been successfully deleted.'
      status = :ok
    else
      message = 'Employee can not be deleted.'
      status = :unprocessible_entity
    end
    render json: { message: message }, status: status
  end

  private
    def employee_params
      params[:employee].slice(:name, :age, :email_id, :location, :department, :designation)
    end

    def load_resource
      @employee = Employee.where(id: params[:id]).first
      unless @employee
        flash[:alert] = 'Employee not found.'
        redirect_to(employees_path) and return
      end
    end
end
