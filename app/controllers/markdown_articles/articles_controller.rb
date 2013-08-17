module MarkdownArticles
  class ArticlesController < ApplicationController
    layout MarkdownArticles.layout
    def index
      @articles = MarkdownArticle.articles
    end
    def show
      path = params[:path]
      begin 
        @article = MarkdownArticle.build(path)
      rescue ArticleNotFoundException => e
        redirect_to "/404", status: 404
      end
    end
  end
end
