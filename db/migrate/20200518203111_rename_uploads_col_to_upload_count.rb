class RenameUploadsColToUploadCount < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :uploads, :upload_count
  end
end
