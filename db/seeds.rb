
account1 = Account.create(email: "nabeel@gmail.com", name: "Nabeel", password: "nouman" , confirmed_at: DateTime.now)
post = account1.posts.create(content: "new post")
post.photos.create(image: File.open("#{Rails.root}/app/assets/images/default.png") )
account1.likes.create(post_id: post.id)
account1.comments.create(post_id: post.id, content:"New comment")


account2 = Account.create(email: "shah@gmail.com", name: "Shah", password: "nouman" , confirmed_at: DateTime.now)
post = account2.posts.create(content: "new post")
post.photos.create(image: File.open("#{Rails.root}/app/assets/images/default2.png") )
account2.likes.create(post_id: post.id)
account2.comments.create(post_id: post.id, content:"New comment")


account3 = Account.create(email: "muaaz@gmail.com", name: "Muaaz", password: "nouman" , confirmed_at: DateTime.now)
post = account3.posts.create(content: "new post")
post.photos.create(image: File.open("#{Rails.root}/app/assets/images/default3.png") )
account3.likes.create(post_id: post.id)
account3.comments.create(post_id: post.id, content:"New comment")
