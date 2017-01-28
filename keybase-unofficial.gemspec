require_relative "lib/keybase"

Gem::Specification.new do |s|
  s.name = "keybase-unofficial"
  s.version = Keybase::VERSION
  s.summary = "keybase-unofficial - An unofficial library for Keybase."
  s.description = "A unofficial library for Keybase"
  s.authors = ["William Woodruff"]
  s.email = "william@tuffbizz.com"
  s.files = Dir["LICENSE", "*.md", ".yardopts", "lib/**/*"]
  s.required_ruby_version = ">= 2.3.0"
  s.homepage = "https://github.com/woodruffw/keybase-unofficial"
  s.license = "MIT"
  s.add_runtime_dependency "faraday", "~> 0"
end
