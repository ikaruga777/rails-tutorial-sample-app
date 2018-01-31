require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count',1 do
      post signup_path, params: { user: { name: "example3",
                                        email: "user@example.com",
                                        password: "foobarbaz",
                                        password_confirmation: "foobarbaz"}}
    end
    follow_redirect!
    assert_template 'users/show'  
    assert_select 'div.alert-success'
  end
end
