class FixPatientSelfTestReportedPositiveColC19Symptoms < ActiveRecord::Migration[5.2]
  def change
    rename_column :c19_symptoms, :patient_self_reported_postive, :patient_self_reported_positive
  end
end
