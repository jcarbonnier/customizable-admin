$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "customizable_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "customizable_admin"
  s.version = CustomizableAdmin::VERSION
  s.authors = ["Julien Carbonnier"]
  s.email = ["jcarbonnier.freelance@gmail.com"]
  s.homepage = "http://jcarbonnier.fr/"
  s.summary = "Customzable admin interface"
  s.description = "Customzable admin interface"
  s.license = "MIT"

  s.files = Dir["{app,config,db,lib,concerns}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "devise", "~> 3.4.1"
  s.add_dependency 'therubyracer'
  s.add_dependency "jquery-rails"#, "~> 4.0.3"
  s.add_dependency "jquery-ui-rails"#, "~> 5.0.3"
  # s.add_dependency 'turbolinks', "~> 2.5.3"
  # s.add_dependency "less-rails", "~> 2.6.0"
  s.add_dependency "simple_form", "~> 3.1.0"
  s.add_dependency "cancancan", '~> 1.10'
  s.add_dependency "will_paginate", '~> 3.0.7'
  s.add_dependency "ancestry"
  # Bootstrap
  s.add_dependency 'sass-rails', '>= 3.2'
  s.add_dependency 'bootstrap-sass', '~> 3.3.4'
  s.add_dependency 'autoprefixer-rails'

  s.add_development_dependency "mysql2"
end
