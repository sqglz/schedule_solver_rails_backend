Fabricator(:business) do
  name Faker::Business.name
end

# Fabricator(:business_with_users, from: :business) do
#   after_create do |business|
#     3.times do
#       user = Fabricate(:user, )
#       Fabricate(:business_user, business: business, user: user)
#     end
#   end
# end
