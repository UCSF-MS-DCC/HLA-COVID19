class DropAndChangeColsLatest < ActiveRecord::Migration[5.2]
  def change
    remove_column :subjects, :exposed_to_covid19_carrier_20_days
    remove_column :subjects, :travel_last_20_days
    remove_column :subjects, :medical_worker
    remove_column :treatments, :start_date
    remove_column :treatments, :end_date
    remove_column :lab_tests, :result_date
    remove_column :hospitalizations, :start_date
    remove_column :hospitalizations, :end_date
    remove_column :c19_symptoms, :c19_test_date
    add_column :hospitalizations, :hospitalization_duration_days, :integer
    add_column :treatments, :treatment_duration_days, :integer
  end
end
