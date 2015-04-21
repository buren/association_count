# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'association_count/version'

Gem::Specification.new do |spec|
  spec.name          = "association_count"
  spec.version       = AssociationCount::VERSION
  spec.authors       = ["Albin Svensson", 'Jacob Burenstam']
  spec.email         = ["albin.svensson@trialbee.com", 'jacob.burenstam@trialbee.com']
  spec.summary       = %q{ A small gem that allows association counts to be included in your base query }
  spec.homepage      = "https://github.com/trialbee/association_count"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "sqlite3-ruby"
  spec.add_development_dependency 'simplecov'   #, '~> 0.7.0'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'

  spec.add_dependency "activerecord"
end
