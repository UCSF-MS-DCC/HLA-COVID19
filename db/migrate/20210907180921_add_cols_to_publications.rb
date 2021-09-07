class AddColsToPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :title, :text
    add_column :publications, :url, :text
    add_column :publications, :authors, :text
    add_column :publications, :pub_date, :date
  end
end
