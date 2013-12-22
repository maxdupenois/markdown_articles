require 'test_helper'

class MarticleTest < ActiveSupport::TestCase
  test "can build a set of markdown articles given a directory" do
    setup
    articles = Marti::Marticle.articles
    assert_equal 1, articles.size
  end
  test "can build an individual article" do
    setup
    test = Marti::Marticle.build("test")
    assert_equal "Max", test.author
  end
  
  def setup
    Marti.config do |config|
      config.article_directory = File.join(File.dirname(__FILE__), *%w[.. fixtures])
    end
  end
end
