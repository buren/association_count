class Post < ActiveRecord::Base
  has_many  :answers
  can_count :answers
end

class Answer < ActiveRecord::Base
  belongs_to  :post
end
