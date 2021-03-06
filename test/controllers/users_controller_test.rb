require 'test_helper'
class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  
  test 'should get signup path' do
    get signup_path
    assert_response :success
  end
  
  test 'should redirect edit when logged in wrong user' do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url
  end
  
  test 'should redirect update when logged in wrong user' do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { email: @user.email, 
                                              name: @user.name,
                                              password: '',
                                              password_confirmation: '',
                                              grade: 1,
                                              major: @user.major } }
    assert_redirected_to root_url
  end
  
  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end
  
  
  
  
  
end
