class ShiftSerializer < ActiveModel::Serializer
  attributes :name, :start_time, :end_time

  def end_time
    object.end_time.strftime("%H:%M:%S")
  end
  
  def start_time
    object.start_time.strftime("%H:%M:%S")
  end

end
