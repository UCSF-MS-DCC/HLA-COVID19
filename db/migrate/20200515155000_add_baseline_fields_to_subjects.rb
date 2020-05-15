class AddBaselineFieldsToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :hlac19_id, :string
    add_column :subjects, :origin_identifier, :string
    add_column :subjects, :country_of_residence, :string
    add_column :subjects, :zip_code, :string
    add_column :subjects, :field_employment, :string

  end
end
