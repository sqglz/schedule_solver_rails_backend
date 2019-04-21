class SessionsController < ApplicationController
  def log_in
    # user = User.find_by(username: params[:username])
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      render json: user, status: 200
    else
      error = "Something went wrong. Email and password did not match"
      render json: {error: error}, status: 404
    end
  end
end
