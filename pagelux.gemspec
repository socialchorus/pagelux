# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pagelux/version'

Gem::Specification.new do |spec|
  spec.name          = "pagelux"
  spec.version       = Pagelux::VERSION
  spec.authors       = ["Rae Bonfanti", "Ryan Buckley", "Kane Baccigalupi", "Sowjanya Mudunuri"]
  spec.email         = ["developers@socialchorus.com"]
  spec.description   = %q{Basic pagination for ActiveRecord::Relation objects}
  spec.summary       = %q{Usage: Pagelux::Query.new(page, limit).perform(the_ar_query)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # spec.add_dependency ''

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
