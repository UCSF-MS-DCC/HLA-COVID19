class AddExposureColsToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :exposed_to_covid19_carrier_20_days, :boolean
    add_column :subjects, :travel_last_20_days, :text
    add_column :subjects, :medical_worker, :boolean
  end
end
