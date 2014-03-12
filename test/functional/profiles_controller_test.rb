require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, id: users(:Kelsey).first_name
    assert_response :success
    assert_redirected_to login_path
    assert_template 'profiles/index'
  end

  test "should render a 404 on profile not found" do
  	get :show, id: "Doesn't Exist"
  	assert_respond :not_found
  end 

end
