Fabricator(:user) do
  email                 { Faker::Internet.email }
  password              'right_Password123'
  password_confirmation 'right_Password123'
  first_name            { Faker::Artist.name }
  last_name             { Faker::Name.last_name }
end

Fabricator(:user_with_business, from: :user) do
  after_create do |user|
    business = Fabricate(:business)
    Fabricate(:business_user, user: user, business: business)
  end
end
