# frozen_string_literal: true

# テストしたいコード
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Ruby on Rails Tutorial Sample App"
    assert_equal full_title("ABCDEEDDD"), "ABCDEEDDD | Ruby on Rails Tutorial Sample App"
  end
end
