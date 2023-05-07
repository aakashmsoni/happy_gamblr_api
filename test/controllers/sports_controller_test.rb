require "test_helper"

class SportsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "index" do
    get "/sports.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Sport.count, data.length
  end
end
