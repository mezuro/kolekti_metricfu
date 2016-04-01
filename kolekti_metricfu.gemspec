# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kolekti_metricfu/version'

Gem::Specification.new do |spec|
  spec.name          = "kolekti_metricfu"
  spec.version       = KolektiMetricfu::VERSION
  spec.authors       = ["Daniel Miranda",
                        "Diego Araújo",
                        "Eduardo Araújo",
                        "Rafael Reggiani Manzo"]
  spec.email         = ["danielkza2@gmail.com",
                        "diegoamc90@gmail.com",
                        "duduktamg@hotmail.com",
                        "rr.manzo@protonmail.com"]
  spec.summary       = %q{Metric collecting support for Ruby that servers Kolekti.}
  spec.homepage      = "https://github.com/mezuro/kolekti_metricfu"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "cucumber", "~> 2.1"
  spec.add_development_dependency "factory_girl", "~> 4.5"
end
