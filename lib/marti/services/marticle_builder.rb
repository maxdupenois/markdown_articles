module Marti
  class MarticleBuilder
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def build
      Marti.cache_store.fetch("marticle/"+path, 
                                         expires_in: Marti.expires_in) do
        file = file_location(path)
        unless File.exists?(file)
          raise ::Marti::Exceptions::ArticleNotFoundException.new("#{path} not found") 
        end
        article = Marti::MarticleParser.new(file).parse
        article.send(:instance_variable_set, "@path".to_sym, path)
        article
      end
    end

    private

    def file_location(path)
      File.join(Marti.article_directory, "#{path}.md")
    end
  end
end
