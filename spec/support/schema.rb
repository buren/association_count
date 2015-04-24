ActiveRecord::Schema.define do
  self.verbose = false

  create_table :posts, :force => true do |t|
    t.string :text
    t.integer :author_id
    t.timestamps null: false
  end

  create_table :answers, :force => true do |t|
    t.string :text
    t.integer :post_id
    t.integer :author_id
    t.timestamps null: false
  end

  create_table :extra_posts, :force => true do |t|
    t.string :text
    t.integer :author_id
    t.timestamps null: false
  end

  create_table :extra_answers, :force => true do |t|
    t.string :text
    t.integer :extra_post_id
    t.integer :author_id
    t.timestamps null: false
  end

  create_table :authors, :force => true do |t|
    t.string :name
    t.timestamps null: false
  end


end