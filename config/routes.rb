Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #User routes show, create, update, delete
  post 'user_token' => 'user_token#create'
  get "/users/:id" => "users#show"
  post "/users" => "users#create"
  put "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"
  get "/profile" => "users#show"


  #Commitment routes index, create, update, destroy
  get "/commitments" => "commitments#index"
  post "/commitments" => "commitments#create"
  put "/commitments/:id" => "commitments#update"
  delete "/commitments/:id" => "commitments#destroy"
end
