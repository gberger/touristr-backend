
class MessagesController < ApplicationController

  # GET /trips/1/matches/2/messages
  def index
    @trip = Trip.find(params[:id])
    @other = Trip.find(params[:other_id])
    @connection = TripConnection.for_trips(@trip, @other)

    authorize! :manage, @trip
    throw :not_mutual unless @connection.mutual?

    render json: @connection.messages
  end

  # POST /trips/1/matches/2/messages
  def create
    @trip = Trip.find(params[:id])
    @other = Trip.find(params[:other_id])

    authorize! :manage, @trip
    throw :not_mutual unless @trip.matches?(@other)

    msg = Message.new(trip_a_id: @trip.id, trip_b_id: @other.id, msg: params[:msg])
    if msg.save
      render json: msg, status: :created
    else
      render json: {messages: msg.errors.messages}, status: :bad_request
    end
  end
end
