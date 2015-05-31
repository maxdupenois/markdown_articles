require 'test_helper'

class MarticleTest < ActiveSupport::TestCase
  test "can build a set of markdown articles given a directory" do
    setup
    articles = Marti::Marticle.articles
    expected = Dir[File.join(Marti.article_directory, "*.md")].count
    assert_equal expected, articles.size
  end
  #test "can build an individual article" do
  #  setup
  #  test = Marti::Marticle.build("test")
  #  assert_equal "Max", test.author
  #end
  
end
