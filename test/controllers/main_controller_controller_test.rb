require 'test_helper'

class MainControllerControllerTest < ActionController::TestCase
  test "should get webhook" do
    get :webhook
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
