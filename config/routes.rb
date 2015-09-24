Rails.application.routes.draw do
  resources :case_files, only: %i[ index create ]
end
