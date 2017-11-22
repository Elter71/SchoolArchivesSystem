# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
['user', 'admin'].each do |role|
  Role.find_or_create_by(name: role)
end
user = User.create(email: 'admin@ezn.pl',password: 'admin12', first_name: 'Imię',last_name: 'Nazwisko')
user.role = Role.find(2)
user.save