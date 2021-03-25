class AddMayGrantAccessToProjectToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :grant_project_access_to, :string
  end
end
