class CommitmentPeopleController < ApplicationController
  
  def index
    commitment_people = CommitmentPerson.all
    render json: commitment_people.as_json
  end

  def create
    commitment_person = CommitmentPerson.new(
      commitment_id: params[:commitment_id],
      person_id: params[:person_id]
    )
    if commitment_person.save
      render json: commitment_person.as_json
    else
      render json: {errors: commitment_person.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    commitment_person = CommitmentPerson.find_by(id: params[:id])
    if commitment_person.destroy
      render json: {message: "Commitment_person deleted succesfully."}
    else
      render json: {errors: commitment_person.errors.full_messages}, status: :bad_request
    end
  end

end
