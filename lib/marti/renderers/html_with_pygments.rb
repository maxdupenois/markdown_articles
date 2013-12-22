require 'redcarpet'
require 'pygments'
module Marti 
  module Renderers
    class HTMLWithPygments < ::Redcarpet::Render::HTML
      def block_code(code, language)
        Pygments.highlight(code, 
                           :lexer => language).gsub(/<pre>/, "<pre>\n")
      end
    end
  end
end
