# frozen_string_literal: true

require_relative 'lib/cova_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'cova_api'
  spec.version       = CovaApi::VERSION
  spec.authors       = ['J.F. Turcot']
  spec.email         = ['jf.turcot@gmail.com']

  spec.summary       = 'Ruby interface for the COVA API'
  spec.description   = 'Ruby interface for the COVA API'
  spec.homepage      = 'https://github.com/jfturcot/cova_apis'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jfturcot/cova_api'
  spec.metadata['changelog_uri'] = 'https://github.com/jfturcot/cova_api/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', ['>= 0.8', '< 2.0']
  spec.add_dependency 'oauth2', '~> 1.4'

  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
