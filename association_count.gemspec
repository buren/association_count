# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'association_count/version'

Gem::Specification.new do |spec|
  spec.name          = 'association_count'
  spec.version       = AssociationCount::VERSION
  spec.authors       = ['Albin Svensson', 'Jacob Burenstam']
  spec.email         = ['burenstam@gmail.com']
  spec.summary       = 'A small gem for ActiveRecord that allows association counts to be included in your base query'
  spec.homepage      = 'https://github.com/buren/association_count'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',      '~> 1.5'
  spec.add_development_dependency 'rake',         '~> 10.0'
  spec.add_development_dependency 'rspec',        '~> 3.2'
  spec.add_development_dependency 'sqlite3',      '~> 1.3'
  spec.add_development_dependency 'simplecov',    '~> 0.7'
  spec.add_development_dependency 'guard',        '~> 2.12'
  spec.add_development_dependency 'guard-rspec',  '~> 4.5'

  spec.add_dependency 'activerecord', '>= 4.0'
end
