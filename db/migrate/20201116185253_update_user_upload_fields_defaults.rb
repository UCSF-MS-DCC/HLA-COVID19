class UpdateUserUploadFieldsDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :can_upload, :boolean, default: :true
    change_column :users, :project_owner, :boolean, default: :true
  end
end
