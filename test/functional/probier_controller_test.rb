require 'test_helper'

class ProbierControllerTest < ActionController::TestCase
  test "should get probier" do
    get :probier
    assert_response :success
  end

end
