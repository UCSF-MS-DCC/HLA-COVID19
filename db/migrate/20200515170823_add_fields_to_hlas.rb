class AddFieldsToHlas < ActiveRecord::Migration[5.2]
  def change
    add_column :hlas, :drb1_1, :string
    add_column :hlas, :drb1_2, :string
    add_column :hlas, :dqb1_1, :string
    add_column :hlas, :dqb1_2, :string
    add_column :hlas, :dpb1_1, :string
    add_column :hlas, :dpb1_2, :string
    add_column :hlas, :a_1, :string
    add_column :hlas, :a_2, :string
    add_column :hlas, :b_1, :string
    add_column :hlas, :b_2, :string
    add_column :hlas, :c_1, :string
    add_column :hlas, :c_2, :string
    add_column :hlas, :dpa1_1, :string
    add_column :hlas, :dpa1_2, :string
    add_column :hlas, :dqa1_1, :string
    add_column :hlas, :dqa1_2, :string
    add_column :hlas, :drbo_1, :string
    add_column :hlas, :drbo_2, :string
    add_column :hlas, :drb345_1, :string
    add_column :hlas, :drb345_2, :string
  end
end
