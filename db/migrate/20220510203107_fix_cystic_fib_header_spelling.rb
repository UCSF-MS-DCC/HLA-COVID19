class FixCysticFibHeaderSpelling < ActiveRecord::Migration[5.2]
  def change
    rename_column :comorbidities, :cycstic_fib, :cystic_fib
  end
end
