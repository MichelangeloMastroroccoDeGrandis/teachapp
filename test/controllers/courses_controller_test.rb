require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "index renders successfully" do
    get courses_url

    assert_response :success
  end
end
