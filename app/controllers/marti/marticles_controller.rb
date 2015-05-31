module Marti
  class MarticlesController < ApplicationController
    layout Marti.layout
    def index
      render :index, locals: { marticles: marticles }
    end

    def show
      render :show, locals: { marticle: marticle, marticles: marticles }
    rescue Errors::ArticleNotFoundError => _
      not_found!
    end

    private

    def not_found!
      redirect_path = Marti.article_not_found_path
      redirect_path << (redirect_path =~ /\?/ ? '&' : '?')
      redirect_path << "article=#{params[:path]}"
      redirect_to redirect_path, status: 404
    end

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
