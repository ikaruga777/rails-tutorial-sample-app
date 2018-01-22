require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "shuld be valid " do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation shuould accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      #assert の第二引数にエラーメッセージ入れて異常ケースを特定する
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation shoul reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example foo@bar_baz.com foo@bar+baz.com fooo@bar..com]
    invalid_addresses.each do | invalid_address |
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses shuld be unique" do
    # ユーザを複製してemailの重複をチェックする
    dumplicate_user = @user.dup
    # emailは大文字小文字区別しない
    dumplicate_user.email = @user.email.upcase
    @user.save
    assert_not dumplicate_user.valid?
  end

  test "email addresses shuld be saved as lower-case" do
    mixed_case_email = "ABcdEFG@ExaMple.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal @user.reload.email, mixed_case_email.downcase
  end
end
