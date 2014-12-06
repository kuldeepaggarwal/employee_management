EmployeeManagement::Application.routes.draw do
  resources :employees, except: :show
  root to: 'employees#index'
end
