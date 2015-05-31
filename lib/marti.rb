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
      configured_check!
      config.article_directory || '.'
    end

    def layout
      configured_check!
      config.layout || "application"
    end

    def cache_store
      configured_check!
      config.cache_store || ActiveSupport::Cache::NullStore.new
    end

    def expires_in
      configured_check!
      config.expires_in || 1.day
    end

    private

    def configured_check!
      return unless config.nil?
      raise Marti::Errors::NotYetConfiguredError.new("Marti has not yet been configured")
    end

  end
end
require "marti/engine"
require "marti/services/marticle_builder"
require "marti/services/marticle_parser"
require "marti/errors/errors"
require "marti/renderers/html_with_pygments"
