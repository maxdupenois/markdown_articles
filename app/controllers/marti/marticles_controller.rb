module Marti
  class MarticlesController < ApplicationController
    rescue_from Marti::Errors::ArticleNotFoundError, &Marti.article_not_found_proc
    layout Marti.layout
    def index
      render :index, locals: { marticles: marticles }
    end

    def show
      render :show, locals: { marticle: marticle, marticles: marticles }
    end

    private

    def marticle
      @martcile ||= builder.build
    end

    def builder
      @builder ||= Marti::MarticleBuilder.new(params[:path])
    end

    def marticles
      @marticles ||= Marticle.articles
    end
  end
end
