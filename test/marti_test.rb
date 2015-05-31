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

  test 'raise an error if not configured' do
    prev_config = Marti.config
    Marti.instance_variable_set('@config', nil)
    error_raised = begin
                     !Marti.article_directory
                   rescue Marti::Errors::NotYetConfiguredError => _
                     true
                   end
    assert error_raised
    # Reset config for rest of tests
    Marti.instance_variable_set('@config', prev_config)
  end
end
