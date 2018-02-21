class UsersController < ApplicationController
  def create
    user = User.new(
      email: params[:email],
      user_name: params[:user_name],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name],
      bio: params[:bio],
      profile_picture: params[:profile_picture]
    )
    if user.save
      render json: {message: "User created succesfully"}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end
end
