class AddAffiliationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :affiliation, :text
  end
end
