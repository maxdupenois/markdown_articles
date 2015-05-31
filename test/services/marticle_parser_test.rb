require 'test_helper'

class MarticleParserTest < ActiveSupport::TestCase
  attr_reader :test_file, :parser

  test 'can deal with a given updated at' do
    setup(:updated)
    article = parser.parse
    assert_equal Time.new(2013, 10, 11, 23, 11, 33), article.last_updated_at
  end

  test 'will use file time if no updated at given' do
    setup(:test)
    article = parser.parse
    expected = File.mtime(test_file)
    assert_equal expected, article.last_updated_at
  end

  test 'will work with any given key value pair' do
    setup(:test)
    article = parser.parse
    assert_equal 'avalue', article.somekey
  end

  test 'will get the correct extract with a given cut' do
    setup(:cut)
    article = parser.parse
    expected = "<h1>Cut test</h1>\n\n<p>hello there</p>"
    assert_equal expected, article.extract
  end

  test 'will correctly handle boolean values' do
    setup(:test)
    article = parser.parse
    assert article.boolean1
    assert_not article.boolean2
  end

  def setup(type=nil)
    path = {
      updated: 'test_with_updated_at',
      cut: 'test_with_cut'
    }.fetch(type, 'test')
    @test_file = File.join(Marti.article_directory, "#{path}.md")
    @parser = Marti::MarticleParser.new(test_file)
  end
end
