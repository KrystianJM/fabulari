require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Fabulari", email: "fabulari@fabulari.com",
                     password: "fabulari", password_confirmation: "fabulari")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "user should have a name" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "user should have an email" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "f" * 81
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "f" * 256
    assert_not @user.valid?
  end

  test "correct email addresses should pass validation" do
    valid_addresses = %w[foobar@foobar.com USER@foo.COM A_US-ER@foo.bar.org
                     first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[fabulari@fabulari,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    duplicate_user.email.upcase
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "FaBUlari@FooBAR.neT"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end
end
