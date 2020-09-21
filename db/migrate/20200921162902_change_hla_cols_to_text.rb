class ChangeHlaColsToText < ActiveRecord::Migration[5.2]
  def change
    change_column :hlas, :a_1, :text
    change_column :hlas, :a_2, :text
    change_column :hlas, :b_1, :text
    change_column :hlas, :b_2, :text
    change_column :hlas, :c_1, :text
    change_column :hlas, :c_2, :text
    change_column :hlas, :dpa1_1, :text
    change_column :hlas, :dpa1_2, :text
    change_column :hlas, :dpb1_1, :text
    change_column :hlas, :dpb1_2, :text
    change_column :hlas, :dqa1_1, :text
    change_column :hlas, :dqa1_2, :text
    change_column :hlas, :dqb1_1, :text
    change_column :hlas, :dqb1_2, :text
    change_column :hlas, :drb1_1, :text
    change_column :hlas, :drb1_1, :text
    change_column :hlas, :drb345_1, :text
    change_column :hlas, :drb345_1, :text

  end
end
