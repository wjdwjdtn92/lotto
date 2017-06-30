require 'test_helper'

class LottoControllerTest < ActionController::TestCase
  test "should get shownum" do
    get :shownum
    assert_response :success
  end

end
