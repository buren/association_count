Author.create(name: 'Jacob')
author = Author.create(name: 'Albin')

post = Post.create(text: "First post!", author: author)

Answer.create(text: 'A1', post: post, author: author)
Answer.create(text: 'A2', post: post, author: author)
