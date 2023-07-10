require "test_helper"

class Admin::ThemeReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_theme_reports_index_url
    assert_response :success
  end
end
