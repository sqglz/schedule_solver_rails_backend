class Api::V1::SchedulesController < ApplicationController
  def index
    render json: Schedule.all
  end
end
