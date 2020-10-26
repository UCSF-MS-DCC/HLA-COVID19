class AddNotifiedOfApprovalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notified_of_approval, :boolean, :null => false, :default => false
  end
end
