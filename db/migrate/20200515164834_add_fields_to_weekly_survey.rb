class AddFieldsToWeeklySurvey < ActiveRecord::Migration[5.2]
  def change
    add_column :weekly_c19_surveys, :tested_past_week, :boolean
    add_column :weekly_c19_surveys, :test_result, :text
    add_column :weekly_c19_surveys, :wait_prior_to_testing, :text
    add_column :weekly_c19_surveys, :wait_for_results, :text
    add_column :weekly_c19_surveys, :new_infections_in_county, :text
    add_column :weekly_c19_surveys, :worried_health, :text
    add_column :weekly_c19_surveys, :wash_hands_freq, :text
    add_column :weekly_c19_surveys, :times_visit_gym, :integer
    add_column :weekly_c19_surveys, :times_visit_restaurant, :integer
    add_column :weekly_c19_surveys, :times_visit_bar, :integer
    add_column :weekly_c19_surveys, :times_visit_movies, :integer
    add_column :weekly_c19_surveys, :times_event_10_people, :integer
    add_column :weekly_c19_surveys, :times_exercise, :integer
    add_column :weekly_c19_surveys, :local_govt_restrictions, :text
    add_column :weekly_c19_surveys, :average_sleep, :integer
  end
end
