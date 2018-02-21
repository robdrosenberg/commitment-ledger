Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #User routes show, create, update, delete
  POST 'user_token' => 'user_token#create'
  GET "/users/:id" => "users#show"
  POST "/users" => "users#create"
  PUT "/users/:id" => "users#update"
  DELETE "/users/:id" => "users#destroy"

  #Commitment routes index, create, update, delete
  GET "/commitments" => "commitments#index"
  POST "/commitments" => "commitments#create"
  PUT "/commitments/:id" => "commitments#update"
  DELETE "/commitments/:id" => "commitments#destroy"
end
