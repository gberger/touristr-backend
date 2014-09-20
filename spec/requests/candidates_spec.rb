require 'rails_helper'

describe "Trips" do
  before(:each) do
    @user = create(:user)
    @trip = create(:trip, user: @user)
    @headers = {'X-API-Key' => @user.api_key}
  end

  describe "GET /trips/:id/candidates" do
    it "allows access" do
      get candidate_find_path(@trip.id), nil, @headers
      expect(response.status).to eq(200)
    end

    it "retrieves the user's trips" do
      other_user = create(:user)
      other_trip = create(:trip, user: other_user)
      get candidate_find_path(@trip.id), nil, @headers
      expect(json.length).to be(1)
      expect(json.last['id']).to eq(other_trip.id)
    end
  end

end
