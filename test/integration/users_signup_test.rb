require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '', 
                                         email: 'invalid@example.com',
                                         password: 'foo',
                                         password_confirmation: 'bar',
                                         grade: 1,
                                         major: '応用化学系' } }
    end
    assert_template 'users/new'
  end
  
  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example User',
                                         email: 'user@example.com',
                                         password: 'foobar',
                                         password_confirmation: 'foobar',
                                         grade: 1,
                                         major: '応用化学' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
