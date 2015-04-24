class Post < ActiveRecord::Base
  has_many  :answers
  can_count :answers
  has_many  :authors, through: :answers
  can_count :authors
  belongs_to :author
end

class Answer < ActiveRecord::Base
  belongs_to  :post
  belongs_to :author
end

class Author < ActiveRecord::Base
  has_many :posts
  has_many :answers
end
