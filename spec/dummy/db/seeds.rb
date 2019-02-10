# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


3.times do |t|
  Content.create!(
    title: "title#{t}",
    description: "description#{t}",
    number: t,
    rank: t
  )
end

3.times do |t|
  num = t * 10
  Content.create!(
    title: "title#{num}",
    description: "descripnumion#{num}",
    number: num,
    rank: num
  )
end