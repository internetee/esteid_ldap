# frozen_string_literal: true

require_relative 'lib/esteid_ldap/version'

Gem::Specification.new do |spec|
  spec.name          = 'esteid_ldap'
  spec.version       = EsteidLdap::VERSION
  spec.authors       = ['Oleg Hasjanov']
  spec.email         = ['oleg.phenomenon@gmail.com']

  spec.summary       = 'A Ruby interface to the ESTEID LDAP'
  spec.homepage      = 'https://github.com/OlegPhenomenon/esteid_ldap'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/OlegPhenomenon/esteid_ldap'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.extra_rdoc_files = ['README.md']

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop', '~> 0.60'
  spec.add_development_dependency 'webmock'
  spec.add_dependency 'activesupport', '~> 6.1'
  spec.add_dependency 'bundler', '~> 2.0'
  spec.add_dependency 'net-ldap', '~> 0.17.0'
  spec.add_dependency 'rake', '~> 13.0'
end
