# frozen_string_literal: true

require_relative "lib/irb/fzf/history/version"

Gem::Specification.new do |spec|
  spec.name = "irb-fzf-history"
  spec.version = IRB::FZF::History::VERSION
  spec.authors = ["José Lara"]
  spec.email = ["jvlara@uc.cl"]

  spec.summary = "Integrate fzf with IRB's reverse search (Ctrl+R)"
  spec.description = "Replace IRB's default reverse search with fzf for a better search experience through command history"
  spec.homepage = "https://github.com/jvlara/irb-fzf-history"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.glob("lib/**/*") + %w[README.md CHANGELOG.md]
  spec.require_paths = ["lib"]

  spec.add_dependency "irb", ">= 1.4.0"
  spec.add_dependency "reline", ">= 0.3.0"

  spec.add_development_dependency "rake", "~> 13.0"
end
