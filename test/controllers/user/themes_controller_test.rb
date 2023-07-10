require "test_helper"

class User::ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_themes_new_url
    assert_response :success
  end

  test "should get index" do
    get user_themes_index_url
    assert_response :success
  end
end
