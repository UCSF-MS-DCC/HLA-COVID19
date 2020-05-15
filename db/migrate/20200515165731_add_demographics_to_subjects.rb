class AddDemographicsToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :sex, :text
    add_column :subjects, :gender, :text
    add_column :subjects, :gender_identity, :text
    add_column :subjects, :asian, :boolean
    add_column :subjects, :pacific_islander, :boolean
    add_column :subjects, :hispanic, :boolean
    add_column :subjects, :african_american, :boolean
    add_column :subjects, :white, :boolean
    add_column :subjects, :education, :boolean
    add_column :subjects, :age, :integer
    add_column :subjects, :ethnicity, :text
  end
end
