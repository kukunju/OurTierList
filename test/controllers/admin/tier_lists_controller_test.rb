require "test_helper"

class Admin::TierListsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_tier_lists_show_url
    assert_response :success
  end

  test "should get index" do
    get admin_tier_lists_index_url
    assert_response :success
  end
end
