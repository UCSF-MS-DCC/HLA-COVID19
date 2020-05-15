Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/auth'
  get 'home/age_data'
  get 'home/sex_data'
  get 'home/ethnicity_data'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
