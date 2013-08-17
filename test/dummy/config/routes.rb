Rails.application.routes.draw do

  mount MarkdownArticles::Engine => "/markdown_articles"
end
