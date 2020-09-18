class DropC19SelfReportAddTypeC19Test < ActiveRecord::Migration[5.2]
  def change
    remove_column :c19_symptoms, :patient_self_reported_positive
    add_column :c19_symptoms, :type_of_c19_test, :string
  end
end
