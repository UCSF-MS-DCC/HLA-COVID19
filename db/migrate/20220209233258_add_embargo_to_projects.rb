class AddEmbargoToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :embargo, :boolean
  end
end
