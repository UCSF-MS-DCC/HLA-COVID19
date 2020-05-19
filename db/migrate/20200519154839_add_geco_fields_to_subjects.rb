class AddGecoFieldsToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :pregnant, :boolean
  end
end
