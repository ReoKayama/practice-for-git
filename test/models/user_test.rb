require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: 'user@example.com', 
                      password: 'foobar', password_confirmation: 'foobar', major: '応用化学', grade: 1)
  end
  
  test 'should be valid?' do
    assert @user.valid?
  end
  
  test 'name should be present' do
    @user.name = '  '
    assert_not @user.valid?
  end
  
  test 'email should be present' do
    @user.email = '  '
    assert_not @user.valid?
  end
  
  test 'name should not be too long' do
    @user.name = 'a' * 21
    assert_not @user.valid?
  end
  
  test 'email should be right style' do
    @user.email = 'a' * 101 + '@example.com'
    assert_not @user.valid?
  end
  
  test 'email should be valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org 
                                          first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} is valid!"
    end
  end
  
  test 'email should not be accept invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end
  
  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
  
  test 'password should be present' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end
  
  
  
  
  
  
  
  
  
  
end
