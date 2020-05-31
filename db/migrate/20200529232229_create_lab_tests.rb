class CreateLabTests < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_tests do |t|

      t.timestamps
    end
  end
end
