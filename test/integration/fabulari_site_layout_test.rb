require 'test_helper'

class FabulariSiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "title", full_title()
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get about_path
    assert_select "title", full_title("About")
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end
