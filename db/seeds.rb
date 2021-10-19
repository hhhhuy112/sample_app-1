# Create a main sample user.
User.create!(name: "UiCA Test",
            email: "example@gmail.com",
            password: "@bc12354",
            password_confirmation: "@bc12354",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

# Generate a bunch of additional users.
99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password = "password"
    User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end