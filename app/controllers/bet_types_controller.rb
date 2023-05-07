class BetTypesController < ApplicationController
  def index
    @bet_types = BetType.all
    render json: @bet_types
  end
end
