class AddImputedByHibaggerToHlas < ActiveRecord::Migration[5.2]
  def change
    add_column :hlas, :imputed_using_hlacovid_platform, :boolean, :default => false
  end
end
