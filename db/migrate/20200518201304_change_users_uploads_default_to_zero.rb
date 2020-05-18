class ChangeUsersUploadsDefaultToZero < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :uploads, 0
  end
end
