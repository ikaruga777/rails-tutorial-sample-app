require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    # ログインページアクセス
    get login_path
    # ページ遷移の書くにはassert_template
    assert_template 'sessions/new'
    # ログイン
    post login_path params: { session: { email: "", password: ""} }
    assert_template 'sessions/new'
    assert_not flash.empty?

    #　ページ遷移したらflashが消えてる?
    get root_path
    assert flash.empty?
  end
end
