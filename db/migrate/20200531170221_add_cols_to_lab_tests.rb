class AddColsToLabTests < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_tests, :result_date, :date
    add_column :lab_tests, :blood_type, :text
    add_column :lab_tests, :rh_factor, :text
    add_column :lab_tests, :wbc, :text
    add_column :lab_tests, :lymphocytes, :text
    add_column :lab_tests, :neutrophils, :text
    add_column :lab_tests, :monocytes, :text
    add_column :lab_tests, :eosinophils, :text
    add_column :lab_tests, :basophils, :text
    add_column :lab_tests, :crp, :text
    add_column :lab_tests, :trop_i, :text
    add_column :lab_tests, :trop_t, :text
    add_column :lab_tests, :bnp, :text
    add_column :lab_tests, :idh, :text
    add_column :lab_tests, :ast, :text
    add_column :lab_tests, :alt, :text
    add_column :lab_tests, :bilirubin, :text
    add_column :lab_tests, :ggt, :text
    add_column :lab_tests, :alp, :text
    add_column :lab_tests, :d_dimer, :text
    add_column :lab_tests, :il6, :text
    add_column :lab_tests, :tumor_necrosis_factor, :text
    add_column :lab_tests, :serum_femtin, :text
    add_column :lab_tests, :hba1c, :text
    add_column :lab_tests, :cholesterol, :text
    add_column :lab_tests, :triglycerides, :text
    add_column :lab_tests, :hdl, :text
    add_column :lab_tests, :ldl, :text
    add_column :lab_tests, :ace, :text
    add_column :lab_tests, :ace2r, :text
    add_column :lab_tests, :hemoglobin, :text
    add_column :lab_tests, :amylase, :text
    add_column :lab_tests, :lipase, :text
    add_column :lab_tests, :urea, :text
    add_column :lab_tests, :creatinine, :text
  end
end
