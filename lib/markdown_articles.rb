require "markdown_articles/engine"
require "markdown_articles/exceptions/article_not_found_exception"
require "markdown_articles/renderers/html_with_pygments"
require 'redcarpet'

module MarkdownArticles
  Config = Struct.new(:article_directory, :cache_store, 
                      :expires_in, :layout)
  def self.config
    @config ||= Config.new
    yield(@config)
  end
  def self.article_directory
    @config.article_directory
  end
  def self.layout
    @config.layout || "application"
  end
  def self.cache_store
    @config.cache_store || ActiveSupport::Cache::NullStore.new
  end
  def self.expires_in
    @config.expires_in || 1.day
  end
end
