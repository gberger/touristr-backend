class TripsController < ApplicationController
  # GET /trips
  def index
    @trips = current_user.trips

    render json: @trips
  end

  # GET /trips/1
  def show
    @trip = Trip.includes(:user).find(params[:id])

    authorize! :read, @trip

    render json: @trip.to_json(include: :user)
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.save
      render json: @trip, status: :created
    else
      render json: {messages: @trip.errors.messages}, status: :bad_request
    end
  end

  # PATCH/PUT /trips/1
  def update
    @trip = Trip.find(params[:id])

    authorize! :manage, @trip

    if @trip.update(trip_params)
      render json: @trip
    else
      render json: {messages: @trip.errors.messages}, status: :bad_request
    end
  end

  # DELETE /trips/1
  def destroy
    @trip = Trip.find(params[:id])

    authorize! :manage, @trip

    @trip.destroy
    head :no_content
  end

  private

  def trip_params
    params.permit(:city, :start_date, :end_date, :purpose)
  end
end
