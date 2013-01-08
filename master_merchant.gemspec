$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "master_merchant/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gem-mastermerchant"
  s.version     = MasterMerchant::VERSION
  s.authors     = ["Joshua Krall"]
  s.email       = ["jkrall@groupon.com"]
  s.homepage    = "https://github.groupondev.com/payments/gem-mastermerchant"
  s.summary     = "Ruby gem for consuming the MasterMerchant API"
  s.description = "A convenient, but thin, wrapper for the MasterMerchant JSON API"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "typhoeus", "~> 0.4.0"
  s.add_dependency "activesupport", "~> 3.2"
  s.add_dependency "activemodel", "~> 3.2"

  s.add_development_dependency "sqlite3"
end
