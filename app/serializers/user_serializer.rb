class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :employment_start_date, :days_employed

  def days_employed
    (DateTime.now.to_date - object.employment_start_date.to_date).to_i
  end
end
