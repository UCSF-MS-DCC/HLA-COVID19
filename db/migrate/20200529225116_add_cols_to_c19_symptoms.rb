class AddColsToC19Symptoms < ActiveRecord::Migration[5.2]
  def change
    add_column :c19_symptoms, :c19_test_date, :date
    add_column :c19_symptoms, :c19_test_result, :text
    add_column :c19_symptoms, :dry_cough, :boolean
    add_column :c19_symptoms, :mucus_cough, :boolean
    add_column :c19_symptoms, :days_cough, :integer
    add_column :c19_symptoms, :difficulty_breathing, :boolean
    add_column :c19_symptoms, :fever, :boolean
    add_column :c19_symptoms, :highest_temp, :boolean
    add_column :c19_symptoms, :days_fever, :integer
    add_column :c19_symptoms, :fatigue, :boolean
    add_column :c19_symptoms, :pain_chest_heart, :boolean
    add_column :c19_symptoms, :pain_back, :boolean
    add_column :c19_symptoms, :runny_nose, :boolean
    add_column :c19_symptoms, :sore_throat, :boolean
    add_column :c19_symptoms, :loss_taste_smell, :text
    add_column :c19_symptoms, :diarrhea, :boolean
    add_column :c19_symptoms, :nauseam, :boolean
    add_column :c19_symptoms, :other_symptoms, :text
  end
end
