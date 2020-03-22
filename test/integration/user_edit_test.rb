require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { email: 'mhartl@example.com',
                                              password: 'foobaz',
                                              password_confirmation: 'foobar',
                                              name: '',
                                              grade: 1,
                                              major: '材料' } }
    assert_template 'users/edit'
  end
  
  test 'successful edit' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = 'Foo Bar'
    major = '融合理工'
    patch user_path(@user), params: { user: {email: 'hartl@example.com',
                                             name: name,
                                             password: '',
                                             password_confirmation: '',
                                             grade: '3',
                                             major: major } }
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.major, major
  end
  
  
end
