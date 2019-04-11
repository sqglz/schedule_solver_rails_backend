class Api::V1::ScheduleController < ApplicationController
  def index
    return status: 404 unless admin_level
    render json: Schedule.where()
  end
end
