class AddFieldsToHospitalizations < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitalizations, :icu_admit, :boolean
    add_column :hospitalizations, :icu_duration_days, :integer
    add_column :hospitalizations, :start_date, :date
    add_column :hospitalizations, :end_date, :date
    add_column :hospitalizations, :reason_hosp_ended, :text
    add_column :hospitalizations, :septic_shock, :boolean
    add_column :hospitalizations, :days_after_c19_septic_shock, :integer
    add_column :hospitalizations, :organ_failure, :boolean
    add_column :hospitalizations, :resp_failure, :boolean
    add_column :hospitalizations, :resp_rate_intake, :text
    add_column :hospitalizations, :resp_breath_per_min, :integer
    add_column :hospitalizations, :blood_o2_sat, :decimal
    add_column :hospitalizations, :highest_resp_support, :text
    add_column :hospitalizations, :days_ventilator, :integer
    add_column :hospitalizations, :pa02_min, :decimal
    add_column :hospitalizations, :fio2_max, :decimal
    add_column :hospitalizations, :lung_infiltrates, :decimal
    add_column :hospitalizations, :pneumonia, :text
    add_column :hospitalizations, :pneumonia_days_after_c19_symptoms, :integer
    add_column :hospitalizations, :ef_echo, :decimal
    add_column :hospitalizations, :hepatits, :boolean
    add_column :hospitalizations, :pancreatitis, :boolean
    add_column :hospitalizations, :pleural_effusion, :boolean
    add_column :hospitalizations, :acute_kidney_failure, :boolean
    add_column :hospitalizations, :acute_kidney_chronic, :boolean
    add_column :hospitalizations, :ascites, :boolean
    add_column :hospitalizations, :dyspnea, :boolean
  
  end
end
