class AddColsToRiskFactors < ActiveRecord::Migration[5.2]
  def change
    add_column :risk_factors, :smoke_100, :text
    add_column :risk_factors, :smoke_freq, :text
    add_column :risk_factors, :alcohol_freq, :text
    add_column :risk_factors, :substances_freq, :text
  end
end
