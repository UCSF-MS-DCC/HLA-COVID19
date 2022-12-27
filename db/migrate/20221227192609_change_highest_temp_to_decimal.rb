class ChangeHighestTempToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column :c19_symptoms, :highest_temp, :decimal
  end
end
