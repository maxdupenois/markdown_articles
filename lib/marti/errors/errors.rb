module Marti
  module Errors
    class MartiError < StandardError; end
    class ArticleNotFoundError < MartiError; end
    class NotYetConfiguredError < MartiError; end
  end
end
