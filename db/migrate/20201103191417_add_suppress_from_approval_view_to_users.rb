class AddSuppressFromApprovalViewToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :suppress_from_approval_view, :boolean, default: :false, null: :false
  end
end
