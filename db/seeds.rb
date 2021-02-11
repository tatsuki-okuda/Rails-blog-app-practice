# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Article.create({title: '新い記事です。', content: '記事のコメントです。'})
# Article.create({title: '追加の記事です', content: '記事のコメントです。'})

johon = User.create!(email: 'johon1@example.com', password: 'password')
emily = User.create!(email: 'emily1@example.com', password: 'password')


# 10.times do
# Article.create(
#     title: Faker::Lorem.sentence(word_count: 5),
#     content: Faker::Lorem.sentence(word_count: 100)
# )
# end

5.times do
    johon.articles.create!(
        title: Faker::Lorem.sentence(word_count: 5),
        content: Faker::Lorem.sentence(word_count: 100)
    )
end

5.times do
    emily.articles.create!(
        title: Faker::Lorem.sentence(word_count: 5),
        content: Faker::Lorem.sentence(word_count: 100)
    )
end
