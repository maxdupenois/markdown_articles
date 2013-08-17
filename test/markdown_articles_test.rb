require 'test_helper'

class MarkdownArticlesTest < ActiveSupport::TestCase
  test "can set and get a config setting" do
    MarkdownArticles.config do |config|
      config.article_directory = "blah"
    end
    assert_equal MarkdownArticles.article_directory, "blah"
  end
  test "truth" do
    assert_kind_of Module, MarkdownArticles
  end
  
end
