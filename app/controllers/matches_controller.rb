class CandidatesController < ApplicationController

  # GET /trips/1/matches
  def find
    @trip = Trip.find(params[:id])

    authorize! :manage, @trip

    @matches = @trip.matches

    render json: @matches.to_json(include: :user)
  end
end
