class Api::V1::ShiftsController < ApplicationController
  def index
    render json: current_business.shifts, each_serializer: ShiftSerializer
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
