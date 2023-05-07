class SportsController < ApplicationController
  def index
    @sports = Sport.all
    render json: @sports
  end
end
