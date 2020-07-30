class AddUploadFilenameToUploadRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :upload_records, :upload_filename, :string
  end
end
