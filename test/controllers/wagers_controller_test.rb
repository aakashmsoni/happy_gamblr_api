require "test_helper"

class WagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "Test", email: "test@test.com", password: "password", password_confirmation: "password")
    @wager = Wager.create(user_id: @user.id, bet_type_id: BetType.first.id, sport_id: Sport.first.id, wager_amount: 1.00, odds: 110, win: true, profit_loss: 1.10)
    post "/sessions.json", params: { email: "test@test.com", password: "password" }
    data = JSON.parse(response.body)
    @jwt = data["jwt"]
  end

  test "index" do
    get "/wagers.json", headers: { "Authorization" => "Bearer #{@jwt}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal @user.wagers.count, data.length
  end

  test "create" do
    assert_difference "Wager.count", 1 do
      post "/wagers.json", params: { bet_type_id: BetType.first.id, sport_id: Sport.first.id, wager_amount: 4.00, odds: 150, win: true }, headers: { "Authorization" => "Bearer #{@jwt}" }
      assert_response 201
    end

    post "/wagers.json", params: {}, headers: { "Authorization" => "Bearer #{@jwt}" }
    assert_response 422

    post "/wagers.json", params: {}
    assert_response 401
  end

  test "show" do
    get "/wagers/#{@user.wagers.first.id}.json", headers: { "Authorization" => "Bearer #{@jwt}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "user_id", "bet_type_id", "sport_id", "wager_amount", "odds", "win", "profit_loss", "created_at", "updated_at"], data.keys

    get "/wagers/#{@user.wagers.first.id}.json"
    assert_response 401

    get "/wagers/2.json", headers: { "Authorization" => "Bearer #{@jwt}" }
    assert_response 400
  end

  test "update" do
    patch "/wagers/#{@wager.id}.json", params: { odds: 250 }, headers: { "Authorization" => "Bearer #{@jwt}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal 250, data["odds"]

    patch "/wagers/#{@wager.id}.json", params: { sport_id: "blue" }, headers: { "Authorization" => "Bearer #{@jwt}" }
    assert_response 422

    patch "/wagers/#{@wager.id}.json", params: { odds: "" }
    assert_response 401
  end

  test "destroy" do
    assert_difference "Wager.count", -1 do
      delete "/wagers/#{Wager.first.id}.json", headers: { "Authorization" => "Bearer #{@jwt}" }
      assert_response 200
    end
    delete "/wagers/#{Wager.first.id}.json"
    assert_response 401
  end
end
