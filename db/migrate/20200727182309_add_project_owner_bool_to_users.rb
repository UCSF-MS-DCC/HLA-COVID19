class AddProjectOwnerBoolToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :project_owner, :boolean
  end
end
