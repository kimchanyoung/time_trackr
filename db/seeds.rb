# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[
  "1: Business Needs/Optimization",
  "2A: Technical Design - Architecture",
  "2B: Implementation Planning",
  "2C: Feature strategy/planning",
  "3A: Code",
  "3B: Test (QA)",
  "4: Review",
  "5: Other",
  nil
].each do |reason|
  Activity.create!(description: reason)
end
