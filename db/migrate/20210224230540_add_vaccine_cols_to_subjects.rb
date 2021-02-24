class AddVaccineColsToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :vaccinated, :boolean
    add_column :subjects, :vaccine_type, :text
  end
end
