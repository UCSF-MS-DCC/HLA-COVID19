class AddTestBoolColumnToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :is_test, :boolean
  end
end
