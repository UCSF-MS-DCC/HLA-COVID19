class AddProjectNameToUploadRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :upload_records, :project, :string
  end
end
