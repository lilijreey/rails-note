# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user = User.create :email => 'xxx@xx.com', password: '123456', password_confirmation: '123456'
Category.create [{name: 'C++'},
                 {name: 'MBA'},
                 {name: 'Games'},
                 {name: 'History'},
                 {name: 'Music'}]

user.articles.create :title => 'Advanced Active Record',
                     :body => 'Models need to relate to each other. In the real world.',
                     :publish_at => Date.today

user.articles.create :title => 'C++ Programming Language',
                     :body => 'C++ father book 4th',
                     :publish_at => Date.today

user.articles.create :title => 'How to read book',
                     :body => 'Tell you the seract of read book',
                     :publish_at => Date.today
