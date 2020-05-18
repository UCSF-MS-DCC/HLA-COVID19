class AddUploadsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uploads, :integer
  end
end
