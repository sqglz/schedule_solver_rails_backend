Fabricator(:business) do
  name Faker::Company.name
end

Fabricator(:business_with_employees, from: :business) do
  after_create do |business|
    3.times do
      user = Fabricate(:user, email: Faker::Internet.unique.email)
      Fabricate(:business_user, business: business, user: user)
    end
  end
end
