require "test_helper"

class Admin::CommentReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_comment_reports_index_url
    assert_response :success
  end
end
