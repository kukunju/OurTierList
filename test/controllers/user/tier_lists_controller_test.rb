require "test_helper"

class User::TierListsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_tier_lists_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_tier_lists_edit_url
    assert_response :success
  end

  test "should get show" do
    get user_tier_lists_show_url
    assert_response :success
  end

  test "should get index" do
    get user_tier_lists_index_url
    assert_response :success
  end
end
