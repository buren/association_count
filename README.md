# AssociationCount [![Build Status](https://travis-ci.org/buren/association_count.svg?branch=master)](https://travis-ci.org/buren/association_count)

Get ActiveRecord association count with ease and without worrying about N+1 queries:
```ruby
Author.all.include_post_count.map(&:post_count)
```

A small gem for ActiveRecord that allows association counts to be included in your base query.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'association_count'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install association_count

## Usage

__Include in specific model__

Simply add

```ruby
class Post < ApplicationRecord
  extend AssociationCount

  # [...]
end
```

__Include in all models__

Rails 5, add it to `ApplicationRecord`

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # [...]
  extend AssociationCount
end
```

Rails 4, add it to `ActiveRecord::Base`

```ruby
ActiveRecord::Base.extend AssociationCount
```

Full example
```ruby
class Foo < ActiveRecord::Base
  has_many  :bars
  can_count :bars
end

class Bar < ActiveRecord::Base
  belongs_to  :foo
end

# Each Foo instance will come with a "preloaded" count method: bar_count
Foo.all.include_bar_count.map(&:bar_count) # only one SQL query executed

# you can also achieve the same with
foos = Foo.all.association_count(Bar)
```

This works for any `has_many` relationship even if it uses non standard foreign keys or is a `has_many :x, through: y`.

:information_source: By default we will use left outer join and __not__ distinct.

You can configure this on per model basis
```ruby
class Foo < ActiveRecord::Base
  has_many  :bars
  can_count :bars, distinct: true, join_type: :joins # can also be left_outer_joins
end
```

or on a case by case basis

```ruby
Foo.all.include_bar_count(distinct: false, join_type: :left_outer_joins)
```

## Configuration

```ruby
AssociationCount.configure do |config|
  config.distinct = false
  config.join_type = :joins # or left_outer_joins
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/buren/association_count/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
