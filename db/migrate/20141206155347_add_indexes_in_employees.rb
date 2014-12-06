class AddIndexesInEmployees < ActiveRecord::Migration
  def change
    add_index :employees, :name
    add_index :employees, :age
    add_index :employees, :department
    add_index :employees, :designation
    add_index :employees, :email_id
    add_index :employees, :location
  end
end
