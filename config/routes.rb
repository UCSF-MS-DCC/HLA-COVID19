Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'home#index'

  get 'home/auth'
  get 'home/project'
  get 'home/subjects_csv'
  get 'home/hla_csv'
  get 'home/c19_symptoms_csv'
  get 'home/comorbidities_csv'
  get 'home/hospitalizations_csv'
  get 'home/lab_tests_csv'
  get 'home/risk_factors_csv'
  get 'home/treatments_csv'
  get 'home/stats_csv'
  get 'home/age_data'
  get 'home/sex_data'
  get 'home/contributor_table_data'
  get 'home/allele_freq_data'
  get 'home/download_manual'
  get 'home/new_account_approval'
  post 'home/new_account_approval_handler'
  get 'upload/index'
  get 'upload/get_report'
  patch 'upload/import_data'
  patch 'upload/store'
  get 'upload/download_template'
  get 'upload/download_dictionary'

  post 'query/data'
  post 'query/import_hla'
  post 'query/hibag_preflight'
  post 'query/user_key'
  post 'home/approve_users'

  get '*unmatched', to: 'error#error_404', via: :all, as: 'error'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
