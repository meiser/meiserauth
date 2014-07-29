$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "meiserauth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "meiserauth"
  s.version     = Meiserauth::VERSION
  s.authors     = ["Stephan Keller"]
  s.email       = ["s.keller@meiser.de"]
  s.homepage    = ""
  s.summary     = "Authenticate with Rails an Active Directory"
  s.description = "Authenticate with Rails an Active Directory"
  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 3.2.8"
  s.add_dependency "net-ldap"
  # s.add_dependency "jquery-rails"
  s.add_development_dependency "net-ldap"
  s.add_development_dependency "sqlite3"
end
