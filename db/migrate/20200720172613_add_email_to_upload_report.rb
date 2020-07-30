class AddEmailToUploadReport < ActiveRecord::Migration[5.2]
  def change
    add_column :upload_records, :uploaded_by, :string
  end
end
