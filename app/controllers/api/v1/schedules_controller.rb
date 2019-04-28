class Api::V1::SchedulesController < ApplicationController
  def index
    render json: Schedule.all
  end

  def show
  end

  def create
  end

  def edit
  end

  def destroy
  end
end
