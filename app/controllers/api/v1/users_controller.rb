class Api::V1::UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(safe_user_params)
    if user.save
      render json: user, serializer: UserSerializer
    else
      render json: user.errors.messages, status: 404
    end
  end

  def edit
    if params[:user_id]
      render json: User.find(params[:user_id]), serializer: UserSerializer
    else
      render status: 404
    end
  end

  def update
    if params[:user_id]
      user = User.find(params[:user_id])
      if user.update(safe_user_params)
        render json: user, status: 204
      else
        render json: user.error.messages, status: 402
      end
    else
      render status: 404
    end
  end

  def destroy
    if User.find(params[:user_id]) && params[:delete_user_acct]
      user.strip_of_all_data
      render json: user, status: 204
    else
      render json: {error: "Something went wrong. Try again."}, status: 404
    end
  end
end
