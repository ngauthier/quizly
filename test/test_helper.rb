ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

Capybara.default_driver = :poltergeist

# ActiveRecord threading patch for poltergeist
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

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

  def refute_see(content, msg = "Expected not to see #{content}")
    assert page.has_no_content?(content), msg
  end
end
