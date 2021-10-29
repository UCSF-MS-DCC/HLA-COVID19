class AddPatientSelfReportedPositiveToC19Symptoms < ActiveRecord::Migration[5.2]
  def change
    add_column :c19_symptoms, :patient_self_reported_positive, :boolean
  end
end
