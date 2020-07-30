class AddUploadTypeToUploadRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :upload_records, :upload_type, :string
  end
end
