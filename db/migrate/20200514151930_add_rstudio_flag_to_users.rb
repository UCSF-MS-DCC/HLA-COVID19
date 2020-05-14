class AddRstudioFlagToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rstudio, :boolean
  end
end
