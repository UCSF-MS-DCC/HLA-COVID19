class AddColsToReadCounts < ActiveRecord::Migration[5.2]
  def change
    add_column :read_counts, :hla_a, :integer
    add_column :read_counts, :hla_b, :integer
    add_column :read_counts, :hla_c, :integer
    add_column :read_counts, :hla_dpa1, :integer
    add_column :read_counts, :hla_dpb1, :integer
    add_column :read_counts, :hla_dqa1, :integer
    add_column :read_counts, :hla_dqb1, :integer
    add_column :read_counts, :hla_drb1, :integer
    add_column :read_counts, :hla_drb3, :integer
    add_column :read_counts, :hla_drb4, :integer
    add_column :read_counts, :hla_drb5, :integer
  end
end
