class DropUnneededTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :anxieties
    drop_table :weekly_c19_surveys
    drop_table :baseline_c19_surveys
    drop_table :families
    drop_table :medical_histories
    drop_table :smoking_histories
  end
end
