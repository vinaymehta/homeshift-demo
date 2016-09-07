Rails.application.routes.draw do
  root :to => 'home#index'
  get '/search' => 'home#search'
end
