class CommitmentsController < ApplicationController

  def index
    commitments = Commitment.all
    render json: commitments.as_json  
  end

  def create
    commitment = Commitment.new(
      what: params[:what],
      who: params[:who],
      when: params[:when],
      status: "Created",
      notes: params[:notes],
      category_id: params[:category_id],
      user_id: current_user.id
    )
    if commitment.save
      render json: commitmentt.as_json
    else
      render json: {errors: commitment.errors.full_messages}, status: :bad_request
    end
  end

  def update
    commitment = Commitment.find_by(id: params[:id])
    commitment.what = params[:what] || commitment.what
    commitment.who = params[:who] || commitment.who
    commitment.when = params[:when] || commitment.when
    commitment.status = params[:status] || commitment.status
    commitment.notes = params[:notes] || commitment.notes
    commitment.category_id = params[:category_id] || commitment.category_id
    if commitment.save
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
