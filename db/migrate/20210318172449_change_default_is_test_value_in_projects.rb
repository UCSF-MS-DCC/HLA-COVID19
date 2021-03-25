class ChangeDefaultIsTestValueInProjects < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :is_test, :boolean, default: false
  end
end
