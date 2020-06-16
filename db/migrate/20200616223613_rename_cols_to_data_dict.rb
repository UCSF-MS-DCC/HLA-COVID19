class RenameColsToDataDict < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :race, :text
    rename_column :subjects, :height, :height_cm
    rename_column :subjects, :weight, :weight_kg
    remove_column :c19_symptoms, :c19_test_result
    add_column :c19_symptoms, :c19_test_result_positive, :boolean
    add_column :c19_symptoms, :patient_self_reported_postive, :boolean
    add_column :hospitalizations, :hospitalization_admit, :boolean
    remove_column :risk_factors, :smoke_100
    add_column :risk_factors, :smoke, :boolean
    

  end
end
