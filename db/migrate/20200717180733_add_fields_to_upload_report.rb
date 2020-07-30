class AddFieldsToUploadReport < ActiveRecord::Migration[5.2]
  def change
    add_column :upload_records, :subjects, :integer
    add_column :upload_records, :bad_columns, :string
  end
end
