require 'test_helper'
require 'rails/performance_test_help'

class LoginTest < ActionDispatch::PerformanceTest
  # Replace this with your real tests.
  def test_login
    get '/login'
  end

  #def setup
  #  login_as('jan.gloser@centrum.cz', 'prodeoetpatria')
  #end
end
