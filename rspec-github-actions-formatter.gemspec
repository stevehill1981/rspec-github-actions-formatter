Gem::Specification.new do |spec|
  spec.name          = "rspec-github-actions-formatter"
  spec.version       = "0.1.3"
  spec.authors       = ["Steve Hill"]
  spec.email         = ["steve@stevehill.xyz"]

  spec.summary       = %q{RSpec formatter for use with GitHub Actions.}
  spec.description   = %q{This custom formatter provides a line-streaming output for RSpec, and will also output annotations from any pending, skipped or failing tests in the format GitHub Actions requires.}
  spec.homepage      = "https://github.com/stevehill1981/rspec-github-actions-formatter"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/stevehill1981/rspec-github-actions-formatter/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec", "~> 3.9.0"
end
