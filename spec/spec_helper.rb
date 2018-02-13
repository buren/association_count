
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start 'rails'

require 'association_count'

require 'active_record'

ActiveRecord::Base.extend AssociationCount
ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                       :database => File.dirname(__FILE__) + "/association_count.sqlite3")
load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'
load File.dirname(__FILE__) + '/support/data.rb'
