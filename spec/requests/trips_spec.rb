require 'rails_helper'

describe "Trips" do
  context "without API key" do
    describe "GET /trips" do
      it "denies access" do
        get trips_path
        expect(response.status).to eq(401)
      end
    end

    describe "POST /trips" do
      it "denies access" do
        post trips_path
        expect(response.status).to eq(401)
      end
    end

    describe "GET /trips/:id" do
      it "denies access" do
        get trip_path(1)
        expect(response.status).to eq(401)
      end
    end

    describe "PATCH/PUT /trips/:id" do
      it "denies access" do
        patch trip_path(1)
        expect(response.status).to eq(401)
      end
    end

    describe "DELETE /trips/:id" do
      it "denies access" do
        delete trip_path(1)
        expect(response.status).to eq(401)
      end
    end
  end

  context "with incorrect API key" do
    before(:each) do
      @user1 = create(:user)
      @user2 = create(:user)
      @trip = create(:trip, user: @user1)
      @headers = {'X-API-Key' => @user2.api_key}
    end

    describe "GET /trips/:id" do
      it "deny access" do
        get trip_path(@trip.id), nil, @headers
        expect(response.status).to eq(403)
      end
    end

    describe "PATCH/PUT /trips/:id" do
      it "deny access" do
        patch trip_path(@trip.id), nil, @headers
        expect(response.status).to eq(403)
      end
    end

    describe "DELETE /trips/:id" do
      it "deny access" do
        delete trip_path(@trip.id), nil, @headers
        expect(response.status).to eq(403)
      end
    end
  end

  context "with correct API key" do
    before(:each) do
      @user = create(:user)
      @trip = create(:trip, user: @user)
      @headers = {'X-API-Key' => @user.api_key}
    end

    describe "GET /trips" do
      it "allows access" do
        get trips_path, nil, @headers
        expect(response.status).to eq(200)
      end

      it "retrieves the user's trips" do
        other_user = create(:user)
        other_trip = create(:trip, user: other_user)
        get trips_path, nil, @headers
        expect(json.length).to be(1)
        expect(json.last['id']).to eq(@trip.id)
      end
    end

    describe "POST /trips" do
      it "allows access" do
        post trips_path, attributes_for(:trip), @headers
        expect(response.status).to eq(201)
      end

      it "creates a new trip" do
        expect {post trips_path, attributes_for(:trip), @headers}
        .to change{Trip.count}.by(1)
      end

      it "creates a new trip that belongs to the user" do
        post trips_path, attributes_for(:trip), @headers
        expect(assigns(:trip).user).to eq(@user)
      end
    end

    describe "GET /trips/:id" do
      it "allows access" do
        get trip_path(@trip.id), nil, @headers
        expect(response.status).to eq(200)
      end

      it "retrieves the given trip" do
        get trip_path(@trip.id), nil, @headers
        expect(json['id']).to eq(@trip.id)
      end
    end

    describe "PATCH/PUT /trips/:id" do
      it "allows access" do
        patch trip_path(@trip.id), nil, @headers
        expect(response.status).to eq(200)
      end

      it "modifies the given trip" do
        patch trip_path(@trip.id), {city: "NY"}, @headers
        expect(assigns(:trip).city).to eq("NY")
      end
    end

    describe "DELETE /trips/:id" do
      it "allows access" do
        delete trip_path(@trip.id), nil, @headers
        expect(response.status).to eq(204)
      end

      it "deletes a trip" do
        expect {delete trip_path(@trip.id), nil, @headers}
        .to change{Trip.count}.by(-1)
      end
    end
  end

end
