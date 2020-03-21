require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

Minitest::Reporters.use!


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def log_in_as(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          name: user.name,
                                          password: password,
                                          grade: user.grade,
                                          major: user.major } }
  end
end
