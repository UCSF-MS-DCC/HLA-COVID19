class AddCanApproveNewUserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :can_approve_new_user, :boolean, null: :false, default: :false
  end
end
