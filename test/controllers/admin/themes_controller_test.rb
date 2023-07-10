require "test_helper"

class Admin::ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_themes_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_themes_show_url
    assert_response :success
  end
end
