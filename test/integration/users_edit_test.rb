# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)

    assert_template 'users/edit'

    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_comfirmation: "bar" } }
    assert_template 'users/edit'
    # TODO: エラー内容出力しとく
    assert_select 'div.alert', "The form contains 3 errors"
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_redirected_to login_url
    # フレンドリーフォワーディングを行うのでセッションにurlを記憶している
    assert_equal session[:forwarding_url], "http://www.example.com" + edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    # リダイレクト後は記憶したURLを空にする
    assert_nil session[:forwarding_url]
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_comfirmation: "" } }
    assert_redirected_to @user
    assert_not flash.empty?

    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
