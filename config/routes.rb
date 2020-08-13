Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/auth'
  get 'home/access'
  get 'home/age_data'
  get 'home/sex_data'
  get 'home/ethnicity_data'
  get 'upload/index'
  get 'upload/get_report'
  patch 'upload/import_data'
  patch 'upload/store'
  get 'upload/download_template'
  get 'upload/download_dictionary'

  post 'query/data'
  post 'query/import_hla'
  post 'query/check_user_credentials'
  post 'home/approve_users'

  get '*unmatched', to: 'error#error_404', via: :all, as: 'error'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
