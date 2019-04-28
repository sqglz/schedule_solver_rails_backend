class Api::V1::SessionsController < ApplicationController
  def log_in
    # user = User.find_by(username: params[:username])
    user = User.find_by(email: safe_user_params[:email])
    if user.authenticate(safe_user_params[:password])
      render json: user, status: 200, serializer: UserSerializer
    else
      error = "Something went wrong. Email and password did not match"
      render json: {error: error}, status: 404
    end
  end
end
