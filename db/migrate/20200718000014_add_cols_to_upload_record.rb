class AddColsToUploadRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :upload_records, :csv_file, :boolean
    add_column :upload_records, :irb_approved_checkbox, :boolean
  end
end
