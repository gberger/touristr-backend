class UsersController < ApplicationController
  skip_before_filter :authenticate, :only => :login

  # POST /users
  def login
    user = User.find_by_uid(params[:uid])
    if user.nil?
      user = User.new(user_params)
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
    params.permit(:provider, :uid, :name, :oauth_token, :oauth_token_expires_at)
  end
end
