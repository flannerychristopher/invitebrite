require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # def log_in_as(user)
  #   current_user = user
  # end

end

class ActionDispatch::IntegrationTest

  # log in as a user for tests
  def log_in_as(user, password: 'password')
      post signin_path, params: { session: { email:    user.email,
                                            password: password } }
  end

end
