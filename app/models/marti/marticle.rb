module Marti
  class Marticle
    attr_reader :content, :path, :last_updated_at, :extract

    def self.articles
      articles = []
      Dir[File.join(Marti.article_directory, "*.md")].each do |file|
        path = file.gsub(/^.*\//, "").gsub(/\.md/, "")
        articles << Marti::MarticleBuilder.new(path).build
      end
      articles.sort_by(&:last_updated_at)
      articles
    end
  end
end
