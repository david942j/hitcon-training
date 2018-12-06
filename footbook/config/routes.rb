Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main#index'
  get '/messages', to: 'messages#show'
  get '/profile/:id', to: 'users#profile'
  get '/settings', to: 'users#settings'
  post '/settings', to: 'users#settings'
  get '/users/logout', to: 'users#logout'
  get '/users/sign_in', to: 'users#sign_in'

  post '/foots/:post_id', to: 'foots#foots'
  get '/foots/:post_id', to: 'foots#foots' # for easier exploit
  post '/messages/send', to: 'messages#send_message'
  post '/post', to: 'main#post'
  post '/users/sign_in', to: 'users#sign_in'

  post '/upload', to: 'users#upload'
end
