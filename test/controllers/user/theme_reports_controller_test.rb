require "test_helper"

class User::ThemeReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get completion" do
    get user_theme_reports_completion_url
    assert_response :success
  end
end
