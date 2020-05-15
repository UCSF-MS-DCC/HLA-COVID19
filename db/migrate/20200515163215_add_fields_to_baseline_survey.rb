class AddFieldsToBaselineSurvey < ActiveRecord::Migration[5.2]
  def change
    add_column :baseline_c19_surveys, :coronavirus_tested, :boolean
    add_column :baseline_c19_surveys, :coronavirus_test_result, :string
    add_column :baseline_c19_surveys, :n_weeks_positive, :integer
    add_column :baseline_c19_surveys, :infections_in_county, :boolean
    add_column :baseline_c19_surveys, :worried_health, :boolean
    add_column :baseline_c19_surveys, :local_gov_restrictions, :text
    add_column :baseline_c19_surveys, :hand_hygience_practices, :text
    add_column :baseline_c19_surveys, :sanitized_phone, :boolean
    add_column :baseline_c19_surveys, :school_age_children_at_home, :text
    add_column :baseline_c19_surveys, :college_age_children_at_home, :text
    add_column :baseline_c19_surveys, :when_college_age_child_return_home, :text
    add_column :baseline_c19_surveys, :child_college_attended, :text
    add_column :baseline_c19_surveys, :child_college_location, :text
    add_column :baseline_c19_surveys, :elderly_immunocompromized_person_interaction, :boolean
    add_column :baseline_c19_surveys, :pets_at_home, :boolean
    add_column :baseline_c19_surveys, :pets_type, :text
    add_column :baseline_c19_surveys, :flu_shot_last_year, :boolean
    add_column :baseline_c19_surveys, :cold_flu_last_year, :boolean
    add_column :baseline_c19_surveys, :n_fever_cold_flu, :integer
    add_column :baseline_c19_surveys, :when_last_fever_cold_flu, :text
    add_column :baseline_c19_surveys, :n_nofever_cold_flu, :boolean
    add_column :baseline_c19_surveys, :when_last_nofever_cold_flu, :text
    add_column :baseline_c19_surveys, :avg_exercise_last_year, :text
  end
end
