class Post < ActiveRecord::Base
  has_many  :answers
  has_many  :authors, through: :answers
  belongs_to :author

  can_count :answers
  can_count :authors
end

class Answer < ActiveRecord::Base
  belongs_to  :post
  belongs_to :author
end

class Author < ActiveRecord::Base
  has_many :posts
  has_many :answers

  can_count :posts
end
