class DropProjectOwnerFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :project_owner
  end
end
