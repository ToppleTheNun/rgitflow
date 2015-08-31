# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rgitflow/version'

Gem::Specification.new do |spec|
  spec.name          = "rgitflow"
  spec.version       = RGitFlow::VERSION
  spec.authors       = ["Richard Harrah"]
  spec.email         = ["topplethenunnery@gmail.com"]

  spec.summary       = %q{A collection of Rake tasks designed to represent Git Flow in a Ruby context.}
  spec.homepage      = "https://nunnery.github.io/rgitflow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.test_files = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(test|spec|features)/}) }
  spec.extra_rdoc_files = `git ls-files -z`.split("\x0").select { |f| f.match(/(.+).(txt|rdoc)/) }

  spec.add_dependency 'rake', '~> 10.0'
  spec.add_dependency 'commander', '~> 4.3'
  spec.add_dependency 'git', '~> 1.2'
  spec.add_dependency 'ansi', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
end
