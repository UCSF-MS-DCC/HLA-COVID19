class AddProjectIdToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :subjects, :project, foreign_key: true
  end
end
