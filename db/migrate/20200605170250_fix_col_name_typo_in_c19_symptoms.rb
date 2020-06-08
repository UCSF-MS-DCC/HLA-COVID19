class FixColNameTypoInC19Symptoms < ActiveRecord::Migration[5.2]
  def change
    rename_column :c19_symptoms, :nauseam, :nausea
  end
end
