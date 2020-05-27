class AddRequestAdditionalPrivsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :request_rstudio_priv, :boolean, :default => false
    add_column :users, :request_upload_priv, :boolean, :default => false
  end
end
