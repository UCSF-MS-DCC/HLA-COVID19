class CreateC19Symptoms < ActiveRecord::Migration[5.2]
  def change
    create_table :c19_symptoms do |t|
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
