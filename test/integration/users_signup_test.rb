require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "baz"}}
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', 8
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count',1 do
      post users_path, params: { user: { name: "Example User",
                                        email: "user@example.com",
                                        password: "foobarbaz",
                                        password_confirmation: "foobarbaz"}}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態は弾かれる
    log_in_as(user)
    assert_not is_logged_in?
    # 有効化トークンが不正
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # トークンはあってるけどメールアドレスが無効
    get edit_account_activation_path(user.activation_token, email: 'wrong_email')
    assert_not is_logged_in?

    # 正常な有効化
    get edit_account_activation_path(user.activation_token, email: user.email)
    # 有効化されていればactivatedとactivated_atが更新される。
    assert user.reload.activated?
    
    follow_redirect!
    assert_template 'users/show'  
    assert is_logged_in?
  end
end
