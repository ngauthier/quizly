ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  fixtures :all

  def fixture_file(path)
    File.new(Rails.root.join("test", "fixtures", "files", path), 'r')
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def assert_see(content, msg = "Expected to see #{content}")
    assert page.has_content?(content), msg
  end
end
