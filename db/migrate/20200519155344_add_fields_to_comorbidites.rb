class AddFieldsToComorbidites < ActiveRecord::Migration[5.2]
  def change
    add_column :comorbidities, :hiv, :boolean
    add_column :comorbidities, :cd4_cell_count, :decimal
    add_column :comorbidities, :hiv_load, :decimal
    add_column :comorbidities, :immunocompromised, :boolean
    add_column :comorbidities, :organ_transplant, :boolean
    add_column :comorbidities, :organ_transplant_type, :text
    add_column :comorbidities, :bone_marrow_transplant, :boolean
    add_column :comorbidities, :autoimmune_rheum_disease, :boolean
    add_column :comorbidities, :diabetes_type_1, :boolean
    add_column :comorbidities, :diabetes_type_2, :boolean
    add_column :comorbidities, :asthma, :boolean
    add_column :comorbidities, :copd, :boolean
    add_column :comorbidities, :cycstic_fib, :boolean
    add_column :comorbidities, :liver_disease, :boolean
    add_column :comorbidities, :gallbladder_disease, :boolean
    add_column :comorbidities, :pancreas_disease, :boolean
    add_column :comorbidities, :angio_coronary_intervention, :boolean
    add_column :comorbidities, :artery_bypass, :boolean
    add_column :comorbidities, :cong_heart_failure, :boolean
    add_column :comorbidities, :hypertension, :boolean
    add_column :comorbidities, :infarction_type_1, :boolean
    add_column :comorbidities, :infarction_type_2, :boolean
    add_column :comorbidities, :peri_vascular_dis, :boolean
    add_column :comorbidities, :stroke, :boolean
    add_column :comorbidities, :arythmia, :boolean
    add_column :comorbidities, :dementia, :boolean
    add_column :comorbidities, :neur_disease, :boolean
    add_column :comorbidities, :leukemia, :boolean
    add_column :comorbidities, :lymphoma, :boolean
    add_column :comorbidities, :malignant_solid_tumor, :boolean
  end
end
