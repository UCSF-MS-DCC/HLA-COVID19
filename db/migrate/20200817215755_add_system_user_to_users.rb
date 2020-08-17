class AddSystemUserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :system_user, :boolean, :default => false, :null => false
  end
end
