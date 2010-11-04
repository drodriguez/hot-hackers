HotHackers::Application.routes.draw do
  root :to => "matches#new"
  resources :matches
  resources :hackers
end
