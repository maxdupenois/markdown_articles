module Marti
  class MarticleParser
    attr_reader :file, :article
    CUT = "--CUT--"
    def initialize(file)
      @file = file
    end

    def parse
      # clear article
      @article = Marticle.new
      set_article_time_from_file!

      content, extract = retrieve_content
      content = markdown.render(content.join("\n"))
      extract = markdown.render(extract.join("\n"))

      set('content', content)
      # Strip last \n from extract
      set('extract', extract.strip)
      article
    end

    private

    def retrieve_content
      content = []
      extract = []
      each_line do |type|
        type.meta do |line|
          parse_meta_line(line)
        end

        type.content do |line|
          line = clean_line(line)
          extract = content.dup and next if line == CUT
          content << line
        end
      end

      extract = content[0..3] if extract.empty?
      [content, extract]
    end

    def set(key, value)
      article.send(:instance_variable_set, "@#{key}", value)
      article.class.send(:attr_reader, key) unless article.respond_to?(key)
    end

    def clean_line(line)
      line.gsub(/[\n\r]/, "")
    end

    def set_article_time_from_file!
      set('last_updated_at', File.mtime(file).to_datetime)
    end

    def parse_meta_line(line)
      key, value = line.gsub(/^\$/, "").split(":").map(&:strip)
      value = parse_value(value)
      # Account for manually setting time
      value = Time.parse(value) if key == 'last_updated_at'
      set(key, value)
    end

    def parse_value(value)
      case value.strip
      when /^[0-9]+(\.[0-9]+)?$/
        value =~ /\./ ? value.to_f : value.to_i
      when /^(?:t|f|y|n|yes|no|true|false)$/i
        !!(value =~ /^(?:t|y|yes|true)$/)
      else
        value
      end
    end

    class LineResponse < Struct.new(:type, :line)
      [:meta, :content].each do |t|
        define_method(t) do |&b|
          return unless type == t
          b.yield(line)
        end
      end
    end

    def each_line(&block)
      in_meta = true
      File.open(file, 'r') do |file|
        file.each_line do |line|
          if line =~ /^\$/ && in_meta
            block.call(LineResponse.new(:meta, line))
          else
            in_meta = false
            block.call(LineResponse.new(:content, line))
          end
        end
      end
    end

    def markdown
      @markdown ||= ::Redcarpet::Markdown.new(
        Marti::Renderers::HTMLWithPygments.new(
          prettify: true,
        ), 
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        autolink: true,
        disable_indented_code_blocks: true,
        strikethrough: true,
        footnotes: true,
        highlight: true,
      )
    end
  end
end
