class UpdateC19Surveys < ActiveRecord::Migration[5.2]
  def change
    remove_column :baseline_c19_surveys, :n_weeks_positive
    remove_column :baseline_c19_surveys, :infections_in_county
    remove_column :baseline_c19_surveys, :worried_health
    remove_column :baseline_c19_surveys, :local_gov_restrictions
    remove_column :baseline_c19_surveys, :hand_hygience_practices
    remove_column :baseline_c19_surveys, :sanitized_phone
    remove_column :baseline_c19_surveys, :school_age_children_at_home
    remove_column :baseline_c19_surveys, :college_age_children_at_home
    remove_column :baseline_c19_surveys, :when_college_age_child_return_home
    remove_column :baseline_c19_surveys, :child_college_attended
    remove_column :baseline_c19_surveys, :child_college_location
    remove_column :baseline_c19_surveys, :elderly_immunocompromized_person_interaction
    remove_column :baseline_c19_surveys, :pets_at_home
    remove_column :baseline_c19_surveys, :pets_type
    remove_column :baseline_c19_surveys, :flu_shot_last_year
    remove_column :baseline_c19_surveys, :cold_flu_last_year
    remove_column :baseline_c19_surveys, :n_fever_cold_flu
    remove_column :baseline_c19_surveys, :when_last_fever_cold_flu
    remove_column :baseline_c19_surveys, :n_nofever_cold_flu
    remove_column :baseline_c19_surveys, :when_last_nofever_cold_flu
    remove_column :baseline_c19_surveys, :avg_exercise_last_year
    remove_column :weekly_c19_surveys, :wait_prior_to_testing
    remove_column :weekly_c19_surveys, :new_infections_in_county
    remove_column :weekly_c19_surveys, :worried_health
    remove_column :weekly_c19_surveys, :wash_hands_freq
    remove_column :weekly_c19_surveys, :times_visit_gym
    remove_column :weekly_c19_surveys, :times_visit_restaurant
    remove_column :weekly_c19_surveys, :times_visit_bar
    remove_column :weekly_c19_surveys, :times_visit_movies
    remove_column :weekly_c19_surveys, :times_event_10_people
    remove_column :weekly_c19_surveys, :times_exercise
    remove_column :weekly_c19_surveys, :local_govt_restrictions
    remove_column :weekly_c19_surveys, :average_sleep



  end
end
