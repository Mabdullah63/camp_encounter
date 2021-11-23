require "test_helper"

class UserApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_applications_show_url
    assert_response :success
  end

  test "should get update" do
    get user_applications_update_url
    assert_response :success
  end
end
