class CreateKirs < ActiveRecord::Migration[5.2]
  def change
    create_table :kirs do |t|
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
