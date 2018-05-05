require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @non_activated = users(:jane)
  end

  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination' , count: 2
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      # 管理者には削除リンクが存在しない
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test 'index as non-activated' do
    # 有効になっていないアカウントは表示されない
    log_in_as(@admin)
    get users_path
    assert_select 'a', text: @non_activated.name, count: 0
  end

  test 'show as non-activated' do
    # 有効になっていないアカウントのユーザページは表示されない
    get user_path(@non_activated)
    assert_equal true,redirect?
    assert_response(:redirect)
    assert_redirected_to root_url
  end
end
