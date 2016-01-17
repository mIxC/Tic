# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create(user_name: "admin", wins: 100, loss: 0, draw: 1, password: 'admin1')

user = User.create(user_name: "111", wins: 10, loss: 1, draw: 1, password: '123456')

user = User.create(user_name: "222", wins: 10, loss: 1, draw: 1, password: '123456')



