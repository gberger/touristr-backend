require "rails_helper"

describe TripsController do
  describe "routing" do

    it "routes to #find" do
      expect(get("/trips/1/candidates")).to route_to("candidates#find", :id => "1")
    end

    it "routes to #accept" do
      expect(post("/trips/1/candidates/2/acceptation")).to route_to("candidates#accept", a_id: "1", b_id: "2")
    end

    it "routes to #reject" do
      expect(post("/trips/1/candidates/2/rejection")).to route_to("candidates#reject", a_id: "1", b_id: "2")
    end

  end
end
