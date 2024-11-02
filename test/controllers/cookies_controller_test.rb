require "test_helper"

class CookiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cookies_index_url
    assert_response :success
  end

  test "should get consent" do
    get cookies_consent_url
    assert_response :success
  end
end
