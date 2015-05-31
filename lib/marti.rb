require 'redcarpet'

module Marti
  class << self
    attr_reader :config
    Config = Struct.new(:article_directory, :cache_store, 
                        :expires_in, :layout)
    def configure
      @config ||= Config.new
      yield(config)
    end

    def article_directory
      config.article_directory
    end

    def layout
      config.layout || "application"
    end

    def cache_store
      config.cache_store || ActiveSupport::Cache::NullStore.new
    end

    def expires_in
      config.expires_in || 1.day
    end
  end
end
require "marti/engine"
require "marti/services/marticle_builder"
require "marti/services/marticle_parser"
require "marti/exceptions/article_not_found_exception"
require "marti/renderers/html_with_pygments"
