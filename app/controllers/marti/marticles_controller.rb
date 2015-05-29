module Marti
  class MarticlesController < ApplicationController
    layout Marti.layout
    def index
      render :index, locals: { marticles: marticles }
    end

    def show
      path = params[:path]
      render :show, locals: { marticle: Marticle.build(path), marticles: marticles }
    rescue ArticleNotFoundException => _
      redirect_to "/404", status: 404
    end

    private

    def marticles
      @marticles ||= Marticle.articles
    end
  end
end
