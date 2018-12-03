# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DatabaseCleaner.clean_with(:truncation)

password = SecureRandom.hex
admin = User.create(account: 'admin', password: password)

p password

Post.create(user_id: admin.id, content: 'One flag is in my cookies, another one is for admin only: https://ppt.cc/f6hrGx')
users = User.create(%w[ddaa aloha test meow david hacker].map { |n| { account: n, password: 'ddaa' + n } })
Post.create(user_id: users[1].id, content: 'Hey admin please give me some food!!!!!!')

post = Post.create(user_id: users[3].id, content: 'Meow~ Meow~ Meow~ <3')
Foot.create(user_id: users[1].id, post_id: post.id)
Foot.create(user_id: users[2].id, post_id: post.id)
Foot.create(user_id: users[3].id, post_id: post.id)

Post.create(user_id: users[4].id, content: "I'm so hungry..")
post = Post.create(user_id: users[4].id, content: 'footbook is much easier to use than facebook!')
Foot.create(user_id: users[1].id, post_id: post.id)
Foot.create(user_id: users[2].id, post_id: post.id)

Post.create(user_id: users[5].id, content: "Give me the flag plz")
Post.create(user_id: users[5].id, content: "~!@\#$%^&*()_+?><")

Post.create(user_id: users[4].id, content: '@hacker what are you talking about?')

post = Post.create(user_id: users[3].id, content: 'Meow, meow meow meow MEOW meow!')
Foot.create(user_id: users[3].id, post_id: post.id)

Secret.create(flag: Figaro.env.flag_db)
