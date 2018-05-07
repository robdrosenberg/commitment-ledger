class CommitmentsController < ApplicationController

  def index
    if current_user
      commitments = current_user.commitments
      render json: commitments.as_json
    end
  end

  def create
    if params[:category_id] == ""
      params[:category_id] = 1
    end
    commitment = Commitment.new(
      what: params[:what],
      who: params[:who],
      due: params[:due],
      status: "Committed",
      notes: params[:notes],
      category_id: params[:category_id],
      user_id: current_user.id
    )
    if commitment.save
      render json: commitment.as_json
    else
      render json: {errors: commitment.errors.full_messages}, status: :bad_request
    end
  end

  def update
    # Time.new(params[:due])
    commitment = Commitment.find_by(id: params[:id])
    commitment.what = params[:what] || commitment.what
    commitment.who = params[:who] || commitment.who
    commitment.due = params[:due] || commitment.due
    commitment.status = params[:status] || commitment.status
    commitment.notes = params[:notes] || commitment.notes
    commitment.category_id = params[:category_id] || commitment.category_id
    if commitment.save
      commitment.commitment_people.destroy_all
      render json: commitment.as_json
    else
      render json: {errors: commitment.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    commitment = Commitment.find_by(id: params[:id])
    if commitment.destroy
      render json: {message: "Commitment Deleted Succesfully"}
    else
      render json: {errors: commitment.errors.full_messages}, status: :bad_request
    end
  end

end
