module Marti
  class MarticlesController < ApplicationController
    layout Marti.layout
    def index
      @marticles = Marticle.articles
    end
    def show
      path = params[:path]
      begin 
        @marticle = Marticle.build(path)
      rescue ArticleNotFoundException => e
        redirect_to "/404", status: 404
      end
    end
  end
end
