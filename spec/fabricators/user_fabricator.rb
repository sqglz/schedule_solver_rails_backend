Fabricator(:user) do
  email           Faker::Internet.email
  password_digest 'right_Password123'
  first_name      Faker::Artist.name
  last_name       Faker::Name.last_name
end
