require "test_helper"

class BetTypesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "index" do
    get "/bet_types.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal BetType.count, data.length
  end
end
