require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    # 送信用ユーザの作成
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)

    # メールの内容確認
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
   
  end

  test "password_reset" do
    # 送信用ユーザの作成
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)

    # メールの内容確認
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end
end
