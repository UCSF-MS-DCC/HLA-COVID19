class AddHospitalizationFieldsToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :baseline_c19_surveys, :hospitalized, :boolean
    add_column :baseline_c19_surveys, :respirator, :boolean
    add_column :baseline_c19_surveys, :c19_symptons, :text
    add_column :weekly_c19_surveys, :hospitalized, :boolean
    add_column :weekly_c19_surveys, :respirator, :boolean
    add_column :weekly_c19_surveys, :c19_symptons, :text
  end
end
