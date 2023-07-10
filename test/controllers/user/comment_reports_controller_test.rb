require "test_helper"

class User::CommentReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get completion" do
    get user_comment_reports_completion_url
    assert_response :success
  end
end
