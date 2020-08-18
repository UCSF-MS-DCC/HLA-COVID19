class AddPopToHlas < ActiveRecord::Migration[5.2]
  def change
    add_column :hlas, :pop, :string
  end
end
