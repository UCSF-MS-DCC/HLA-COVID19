class UpdateSubjectsTableColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :subjects, :zip_code
    remove_column :subjects, :field_employment
    remove_column :subjects, :gender_identity
    remove_column :subjects, :asian
    remove_column :subjects, :pacific_islander
    remove_column :subjects, :hispanic
    remove_column :subjects, :african_american
    remove_column :subjects, :white
    add_column :subjects, :ancestry, :text
    add_column :subjects, :height, :integer
    add_column :subjects, :weight, :integer
  end
end
