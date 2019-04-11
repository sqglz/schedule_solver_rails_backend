Fabricator(:user) do
  email                 Faker::Internet.unique.email(Faker::FunnyName.unique.two_word_name, '+')
  password              'right_Password123'
  password_confirmation 'right_Password123'
  first_name            Faker::Artist.name
  last_name             Faker::Name.last_name
  user_role             0
end

Fabricator(:user_with_business, from: :user) do
  user_role             3

  after_create do |user|
    business = Fabricate(:business)
    Fabricate(:business_user, user: user, business: business)
  end
end

Fabricator(:worker, from: :user) do
  user_role             1
end

Fabricator(:manager_with_schedule, from: :user) do
  user_role             2

  after_create do |user|
    owner = Fabricate(:user_with_business)
    business = Business.last

    Fabricate(:business_user, user: user, business: business)

    3.times do
      worker = Fabricate(:worker)
      Fabricate(:business_user, user: worker, business: business)
    end

    schedule = Fabricate(:schedule, owner_id: owner.id, default: true)

    3.times do
      Fabricate(
        :shift_with_assignments,
        business: business,
        schedule_id: schedule.id
      )
    end
  end
end
