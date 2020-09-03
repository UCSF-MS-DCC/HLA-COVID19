class ChangeDrboColtypeToBool < ActiveRecord::Migration[5.2]
  def change
    change_column :hlas, :drbo_1, :boolean
    change_column :hlas, :drbo_2, :boolean
  end
end
