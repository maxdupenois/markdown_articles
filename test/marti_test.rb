require 'test_helper'

class MartiTest < ActiveSupport::TestCase
  test "can set and get a config setting" do
    prev_dir = Marti.article_directory
    Marti.configure do |config|
      config.article_directory = "blah"
    end
    assert_equal Marti.article_directory, "blah"
    # Reset config for rest of tests
    Marti.configure do |config|
      config.article_directory = prev_dir
    end
  end
end
