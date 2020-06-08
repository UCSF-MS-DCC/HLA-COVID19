class AddProjectNameToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :project_name, :string
  end
end
