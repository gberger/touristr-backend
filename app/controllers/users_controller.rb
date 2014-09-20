class UsersController < ApplicationController
  skip_before_filter :authenticate, :only => :login

  # POST /users
  def login
    user = User.find_by_uid(params[:userID])
    if user.nil?
      user = User.new_from_facebook(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: {messages: user.errors.messages}, status: :bad_request
      end
    else
      render json: user, status: :ok
    end
  end

  def user_params
    params.permit(:userID, :accessToken, :expiresIn, :signedRequest)
  end
end
