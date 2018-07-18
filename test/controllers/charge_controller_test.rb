require 'test_helper'

class ChargeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get charge_create_url
    assert_response :success
  end

end
