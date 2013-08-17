class MarkdownArticle
  attr_reader :content, :path, :last_updated_at, :extract

  def self.build(path)
    MarkdownArticles.cache_store.fetch("marticle/"+path, 
                                       expires_in: MarkdownArticles.expires_in) do
      file = file_location(path)
      unless File.exists?(file)
        raise ArticleNotFoundException.new("#{path} not found") 
      end
      article = parse_file(file)
      article.send(:instance_variable_set, "@path".to_sym, path)
      article
    end
  end

  def self.articles
    articles = []
    Dir[File.join(MarkdownArticles.article_directory, "*.md")].each do |file|
      path = file.gsub(/^.*\//, "").gsub(/\.md/, "")
      articles << MarkdownArticle.build(path)
    end
    articles.sort_by(&:last_updated_at)
    articles
  end
  
  private

  def self.parse_file(file)
    article = MarkdownArticle.new
    in_meta = true
    content = []
    extract = []
    article.send(:instance_variable_set, "@last_updated_at".to_sym,
                 File.mtime(file).to_datetime)
    File.open(file, 'r') do |file|
      file.each_line do |line|
        if line =~ /^\$/ && in_meta
          key, value = line.gsub(/^\$/, "").split(":").map(&:strip)
          article.send(:instance_variable_set, "@#{key}".to_sym, value)
          article.class.send(:attr_reader, key.to_sym)
        else
          in_meta = false
          if line =~ /--CUT--/
            extract = content.dup
            next
          end
          content << line
        end
      end
    end
    if extract.empty?
      extract = content[0..5]
    end
    content = markdown.render(content.join("\n"))
    extract = markdown.render(extract.join("\n"))
    article.send(:instance_variable_set, "@content".to_sym, content)
    article.send(:instance_variable_set, "@extract".to_sym, extract)
    article
  end

  def self.file_location(path)
    File.join(MarkdownArticles.article_directory, "#{path}.md")
  end

  def self.markdown
    @markdown ||= ::Redcarpet::Markdown.new(
      ::Redcarpet::Render::HTML, 
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      superscript: true,
      highlight: true
    )
  end
end
