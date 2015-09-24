Rails.application.routes.draw do
  get '/' => redirect('/case-files')
  resources :case_files, path: 'case-files', only: %i[ index create ]
end
