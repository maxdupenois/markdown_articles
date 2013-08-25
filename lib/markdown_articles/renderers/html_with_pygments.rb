require 'pygments'
module MarkdownArticles 
  module Renderers
    class HTMLWithPygments < ::Redcarpet::Render::HTML
      def block_code(code, language)
        code = code.gsub(/\n\s*\n/m, "\n")
        Pygments.highlight(code, :lexer => language)
      end
    end
  end
end
