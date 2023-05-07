require "test_helper"

class WagersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "index" do
    get "/wagers.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Wager.count, data.length
  end

  test "create" do
    assert_difference "Wager.count", 1 do
      post "/wagers.json", params: {
                             user_id: 1,
                             bet_type_id: 1,
                             sport_id: 1,
                             wager_amount: 1.00,
                             odds: 110,
                             win: true,
                             profit_loss: 1.10,
                           }
      assert_response 201
    end
  end

  test "show" do
    get "/wagers/#{Wager.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "user_id", "bet_type_id", "sport_id", "wager_amount", "odds", "win", "profit_loss", "created_at", "updated_at"], data.keys
  end
end
