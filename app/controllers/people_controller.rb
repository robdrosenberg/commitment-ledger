class PeopleController < ApplicationController
  def index
    if current_user
      people = current_user.people
      render json: people.as_json
    end
  end

  def create
    person = Person.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      description: params[:description],
      avatar: params[:avatar],
      user_id: current_user.id,
      brownies: 0
    )
    if person.save
      render json: person.as_json
    else
      render json: {errors: person.errors.full_messages}, status: :bad_request
    end
  end

  def show
    if current_user
      person = Person.find_by(id: params[:id])
      render json: person.as_json
    end
  end

  def update
    person = Person.find_by(id: params[:id])
    person.email = params[:email] || person.email
    person.first_name = params[:first_name] || person.first_name
    person.last_name = params[:last_name] || person.last_name
    person.description = params[:description] || person.description
    person.phone_number = params[:phone_number] || person.phone_number
    person.brownies = params[:brownies] || person.brownies
    person.avatar = params[:avatar] || person.avatar
    if person.save
      render json: person.as_json
    else
      render json: {erroes: person.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    person = Person.find_by(id: params[:id])
    if person.destroy
      render json: {message: "User deleted succesfully."}
    else
      render json: {errors: person.errors.full_messages}, status: :bad_request
    end
  end


end
