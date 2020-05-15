class CreateMedicalHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_histories do |t|
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
