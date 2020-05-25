class AddRstudioCredsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rstudio_username, :string
    add_column :users, :rstudio_password, :string
  end
end
