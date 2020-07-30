class FixHepatitisColName < ActiveRecord::Migration[5.2]
  def change
    rename_column :hospitalizations, :hepatits, :hepatitis
  end
end
