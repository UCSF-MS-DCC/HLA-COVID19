class AddProjectNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :project_name, :string
  end
end
