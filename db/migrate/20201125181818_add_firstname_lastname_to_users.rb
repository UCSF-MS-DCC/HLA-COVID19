class AddFirstnameLastnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string, :null => false
    add_column :users, :lastname, :string, :null => false
  end
end
