# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sms_sender/version'

Gem::Specification.new do |spec|
  spec.name          = 'sms_sender'
  spec.version       = SmsSender::VERSION
  spec.authors       = ['Anton Kiba']
  spec.email         = ['akiba788@mail.ru']

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/akiba88/sms_sender'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 5.0'
  spec.add_dependency 'pg'

  spec.add_dependency 'savon', '~> 2.11.0'
  spec.add_dependency 'http.rb', '~> 0.11.1'

  spec.add_dependency 'slack-notifier', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.5'
  spec.add_development_dependency 'generator_spec'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'rubocop', '~> 0.41.2'
  spec.add_development_dependency 'byebug', '~> 9.0'
end
