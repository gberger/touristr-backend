class CandidatesController < ApplicationController

  # GET /trips/1/candidates
  def find
    @trip = Trip.find(params[:id])

    authorize! :manage, @trip

    cand = @trip.find_candidates
    render json: cand.to_json(include: :user)
  end

  # POST /trips/1/candidates/2/acceptation
  def accept
    @trip_a = Trip.find(params[:a_id])
    @trip_b = Trip.find(params[:b_id])

    authorize! :manage, @trip_a
    @connection = TripConnection.for_trips(@trip_a, @trip_b)
    @connection.status = :accepted
    if connection.save
      head :ok
    else
      render json: {messages: @connection.errors.messages}, status: :bad_request
    end
  end

  # POST /trips/1/candidates/2/rejection
  def reject
    @trip_a = Trip.find(params[:a_id])
    @trip_b = Trip.find(params[:b_id])

    authorize! :manage, @trip_a
    @connection = TripConnection.for_trips(@trip_a, @trip_b)
    @connection.status = :rejected
    if connection.save
      head :ok
    else
      render json: {messages: @connection.errors.messages}, status: :bad_request
    end
  end
end
