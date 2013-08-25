$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "markdown_articles/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "markdown_articles"
  s.version     = MarkdownArticles::VERSION
  s.authors     = ["Max Dupenois"]
  s.email       = ["max.dupenois@gmail.com"]
  s.homepage    = "http:://3void.com"
  s.summary     = "Allows for really simple markdown baed articles"
  s.description = "As I said in the summary"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "redcarpet"
  s.add_dependency "pygments.rb"
  s.add_development_dependency "pg"
end
