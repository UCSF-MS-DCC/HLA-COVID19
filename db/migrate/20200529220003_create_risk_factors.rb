class CreateRiskFactors < ActiveRecord::Migration[5.2]
  def change
    create_table :risk_factors do |t|
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
