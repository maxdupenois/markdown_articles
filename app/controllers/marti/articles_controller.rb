module Marti
  class ArticlesController < ApplicationController
    layout Marti.layout
    def index
      @articles = Marticle.articles
    end
    def show
      path = params[:path]
      begin 
        @article = Marticle.build(path)
      rescue ArticleNotFoundException => e
        redirect_to "/404", status: 404
      end
    end
  end
end
