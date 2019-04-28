class UserSerializer < ActiveModel::Serializer
  attributes  :first_name, :last_name, :employment_start_date, :days_employed,
              :email

  def days_employed
    if !object.employment_start_date
      (DateTime.now.to_date - object.employment_start_date&.to_date.to_i)
    else
      DateTime.now.to_date - object.employment_start_date&.to_date
    end
  end
end
