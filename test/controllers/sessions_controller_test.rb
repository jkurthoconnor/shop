require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "prompts for login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    test_user = users(:one)
    post login_url, params: {name: test_user.name, password: 'secret'}
    assert_redirected_to admin_url
    assert_equal test_user.id, session[:user_id]
  end

  test "should fail login" do
    test_user = users(:two)
    post login_url, params: {name: 'fat-finger typos', password: 'secret'}
    assert_redirected_to login_url
    assert_nil session[:user_id]
  end

  test "should logout" do
    test_user = users(:one)
    post login_url, params: {name: test_user.name, password: 'secret'}

    delete logout_url
    assert_redirected_to store_index_url
    assert_nil session[:user_id]
  end
end
