require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get oauth" do
    get :oauth
    assert_response :success
  end

end
