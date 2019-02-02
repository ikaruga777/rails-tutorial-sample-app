# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # ユーザはログインしてる?
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # テストユーザでログインする
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path params: { session: { email: user.email,
                                         password: password,
                                         remember_me: remember_me } }
  end
end
