require File.expand_path('../lib/nsqrb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'nsqrb'
  gem.version     = Nsqrb::VERSION
  gem.description = gem.summary = "Basic ruby NSQ (http://nsq.io) client library"
  gem.authors     = ["Mikhail Salosin"]
  gem.email       = 'mikhail@salosin.me'
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- test/*`.split("\n")
  gem.homepage    = 'http://rubygems.org/gems/nsqrb'
  gem.license     = 'MIT'
end
