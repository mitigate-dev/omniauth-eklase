require File.expand_path('../lib/omniauth-eklase/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "omniauth-eklase"
  spec.version       = Omniauth::Eklase::VERSION
  spec.authors       = ["Edgars Beigarts"]
  spec.email         = ["edgars.beigarts@gmail.com"]
  spec.description   = "e-klase.lv strategy for OmniAuth."
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/mak-it/omniauth-eklase"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "omniauth-oauth2", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 8.0"
  spec.add_development_dependency "webmock", '~> 1.0'
  spec.add_development_dependency "rack-test"
end
