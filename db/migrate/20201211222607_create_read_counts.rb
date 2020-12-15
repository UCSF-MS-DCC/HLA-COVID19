class CreateReadCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :read_counts do |t|
      t.references :hla, foreign_key: true

      t.timestamps
    end
  end
end
