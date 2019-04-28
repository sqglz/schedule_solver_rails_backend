class UserSerializer < ActiveModel::Serializer
  attributes  :first_name, :last_name, :employment_start_date, :days_employed,
              :email, :user_role, :business, :worker_responsibilities
end
