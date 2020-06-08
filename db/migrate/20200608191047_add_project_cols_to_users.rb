class AddProjectColsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :project_owner, :string, :array => true
    add_column :users, :approved_access, :string, :array => true
  end
end
