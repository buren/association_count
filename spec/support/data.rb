au = Author.create(name: 'Albin')
p  = Post.create(text: "First post!", author: au)
 
Answer.create(text: 'A1', post: p, author: au)
Answer.create(text: 'A2', post: p, author: au)