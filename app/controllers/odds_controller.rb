class OddsController < ApplicationController
  def index
    # url = URI("https://api.the-odds-api.com/v4/sports/?apiKey=#{Rails.application.credentials.happy_gamblr_api[:api_key]}")
    url = URI("https://api.the-odds-api.com/v4/sports/basketball_nba/odds/?apiKey=#{Rails.application.credentials.happy_gamblr_api[:api_key]}&regions=us2&markets=h2h,spreads,totals&oddsFormat=american")
    response = Net::HTTP.get_response(url)

    data = JSON.parse(response.body)
    render json: data.as_json
  end
end
