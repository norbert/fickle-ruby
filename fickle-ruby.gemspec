Gem::Specification.new do |s|
  s.name        = "fickle-ruby"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Norbert Crombach"]
  s.email       = ["norbert.crombach@primetheory.org"]
  s.homepage    = "http://github.com/norbert/fickle-ruby"
  s.summary     = %q{Experimental machine learning REST API client.}

  s.rubyforge_project = "fickle-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(/^test\//)
  s.require_paths = ["lib"]

  s.add_dependency 'faraday'
  s.add_dependency 'multi_json'
  s.add_development_dependency 'rake'
end
