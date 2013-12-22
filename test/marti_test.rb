require 'test_helper'

class MartiTest < ActiveSupport::TestCase
  test "can set and get a config setting" do
    Marti.config do |config|
      config.article_directory = "blah"
    end
    assert_equal Marti.article_directory, "blah"
  end
  test "truth" do
    assert_kind_of Module, Marti
  end
  
end
