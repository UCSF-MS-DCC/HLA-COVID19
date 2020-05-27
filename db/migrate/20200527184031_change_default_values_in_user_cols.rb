class ChangeDefaultValuesInUserCols < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :rstudio, :boolean, :default => false
    change_column :users, :approved, :boolean, :default => false
    change_column :users, :can_upload, :boolean, :default => false
  end
end
