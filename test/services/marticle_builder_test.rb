require 'test_helper'

class MarticleBuilderTest < ActiveSupport::TestCase
  attr_reader :path, :builder

  test 'it should build an article given a path' do
    setup(:test)
    article = builder.build
    assert article.is_a?(Marti::Marticle)
  end

  test 'it should set the path of the marticle' do
    setup(:test)
    article = builder.build
    assert_equal path, article.path
  end

  test 'it should raise an error if the file does not exist' do
    setup(:invalid)
    error_raised = begin
                     !builder.build 
                   rescue Marti::Errors::ArticleNotFoundError => _
                     true
                   end
    assert error_raised
  end

  def setup(type=nil)
    @path = {
      updated: 'test_with_updated_at',
      cut: 'test_with_cut',
      invalid: 'asdsadasdsad'
    }.fetch(type, 'test')
    @builder = Marti::MarticleBuilder.new(path)
  end
end
