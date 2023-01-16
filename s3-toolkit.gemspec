# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "s3-toolkit/version"

Gem::Specification.new do |spec|
  spec.name = "s3-toolkit"
  spec.version = S3Toolkit::VERSION
  spec.authors = ["John Mortlock"]
  spec.email = ["john.mortlock@sealink.com.au"]

  spec.summary = "Simple tools for managing s3 buckets in ruby"
  spec.description = "Simple tools to download contents of s3 buckets when the aws cli is to big a dependency to use"
  spec.homepage = "https://github.com/sealink/s3-toolkit"
  spec.license = "MIT"

  spec.files = Dir["CHANGELOG.md", "README.md", "s3-toolkit.gemspec", "lib/**/*"]
  spec.bindir = "exe"
  spec.executables = ["s3-toolkit"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "aws-sdk-s3", "~> 1"
  spec.add_dependency "dry-cli"

  spec.add_development_dependency "coverage-kit"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "standard"
end
