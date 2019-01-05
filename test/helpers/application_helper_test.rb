require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Fabulari"
    assert_equal full_title("About"), "About | Fabulari"
  end
end
