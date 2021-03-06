# frozen_string_literal: true

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    # ログインページアクセス
    get login_path
    # ページ遷移の書くにはassert_template
    assert_template 'sessions/new'
    # ログイン
    post login_path params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?

    # 　ページ遷移したらflashが消えてる?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path
    assert_template 'sessions/new'

    post login_path params: { session: { email: @user.email, password: "password" } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # ヘッダーの切り替えができてる
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path

    # 二つ目のブラウザでログアウトをクリックしたときのシミュレート
    delete logout_path
    follow_redirect!
    # ヘッダーの切り替えができてる
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    # remember_tokenはいるよね?
    # assignsはコントローラ内のインスタンス変数を参照できる
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    # クッキー保存する場合
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # クッキー保存しない場合
    log_in_as(@user, remember_me: '0')
    # remember_tokenはいないよね?
    puts cookies
    assert_empty cookies['remember_token']
  end
end
