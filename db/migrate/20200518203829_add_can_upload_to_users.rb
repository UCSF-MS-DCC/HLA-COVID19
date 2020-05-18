class AddCanUploadToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :can_upload, :boolean
  end
end
