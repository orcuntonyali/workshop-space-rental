# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

arianna = User.create!(email: "a@exmaple.com", password: "123456")
orcun = User.create!(email: "o@example.com", password: "123456")

my_users = [arianna, orcun]

20.times do

    Space.create!(
        title: "#{Faker::ProgrammingLanguage.name} space",
        user: my_users.sample
    )

end