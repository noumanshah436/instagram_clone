
account = Account.create(email: "anasdx1590@gmail.com", name: "Anas", password: "nouman" , confirmed_at: DateTime.now)


post = account.posts.new(content: "new post")
post.save

post.photos.create(image: File.open("#{Rails.root}/app/assets/images/default.png") )

account.likes.create({post_id: post.id})

account.comments.create({post_id: post.id, content:"New comment"})
