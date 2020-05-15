class CreateAnxieties < ActiveRecord::Migration[5.2]
  def change
    create_table :anxieties do |t|
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
