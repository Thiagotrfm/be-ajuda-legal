# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({name: 'Thiago', last_name: 'Moreira', email: 't_moreira@outlook.com', password: 'thiago19', cpf: '00000000000'})
User.create({name: 'Rafael', last_name: 'Felix', email: 'r_felix@outlook.com', password: 'thiago19', cpf: '11111111111'})