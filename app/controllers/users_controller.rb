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

  def show
    user = User.find_by(id: params[:id])
    render json: user.as_json
  end

  def update
    user = User.find_by(id: params[:id])
    user.email = params[:email] || user.email
    user.user_name = params[:user_name] || user.user_name
    user.first_name = params[:first_name] || user.first_name
    user.last_name = params[:last_name] || user.last_name
    user.bio = params[:bio] || user.bio
    user.profile_picture = params[:profile_picture] || user.profile_picture
    if user.save
      render json: photo.as_json
    else
      render json: {erroes: user.errors.full_messages}, status: :bad_request
    end

  end

  def destroy
    user = User.find_by(id: params[:id])
    if user.destroy
      render json: {message: "User deleted succesfully."}
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end

end
