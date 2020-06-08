class ChangeDataTypeColC19Symptoms < ActiveRecord::Migration[5.2]
  def change
    change_column :c19_symptoms, :highest_temp, :integer
  end
end
