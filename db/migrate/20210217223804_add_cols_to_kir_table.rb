class AddColsToKirTable < ActiveRecord::Migration[5.2]
  def change
    add_column :kirs, :k2dl4_1, :string
    add_column :kirs, :k2dl4_2, :string
    add_column :kirs, :k2dl23_1, :string
    add_column :kirs, :k2dl23_2, :string
    add_column :kirs, :k3dl1s1_1, :string
    add_column :kirs, :k3dl1s1_2, :string
    add_column :kirs, :k3dl2_1, :string
    add_column :kirs, :k3dl2_2, :string
    add_column :kirs, :k3dl3_1, :string
    add_column :kirs, :k3dl3_2, :string
    add_column :kirs, :k2dl1_1, :string
    add_column :kirs, :k2dl1_2, :string
  end
end
