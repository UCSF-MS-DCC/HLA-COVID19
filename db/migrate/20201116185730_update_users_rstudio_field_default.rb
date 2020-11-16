class UpdateUsersRstudioFieldDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :rstudio, :boolean, default: :true
    remove_column :users, :request_rstudio_priv
    remove_column :users, :request_upload_priv
  end
end
