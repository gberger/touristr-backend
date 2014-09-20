require "rails_helper"

describe TripsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/trips")).to route_to("trips#index")
    end

    it "routes to #show" do
      expect(get("/trips/1")).to route_to("trips#show", :id => "1")
    end

    it "routes to #create" do
      expect(post("/trips")).to route_to("trips#create")
    end

    it "routes to #update (PUT)" do
      expect(put("/trips/1")).to route_to("trips#update", :id => "1")
    end

    it "routes to #update (PATCH)" do
      expect(patch("/trips/1")).to route_to("trips#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/trips/1")).to route_to("trips#destroy", :id => "1")
    end

  end
end
