Fabricator(:user) do
  email                 { Faker::Internet.email }
  password              'right_Password123'
  password_confirmation 'right_Password123'
  first_name            { Faker::Artist.name }
  last_name             { Faker::Name.last_name }
end
