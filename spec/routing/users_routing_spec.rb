require "rails_helper"

describe  UsersController do
  describe "routing" do

    it "routes to #login" do
      expect(post("/users")).to route_to("users#login")
    end

  end
end
