class WagersController < ApplicationController
  def index
    @wagers = Wager.all
    render json: @wagers
  end

  def create
    @wager = Wager.new(
      user_id: params[:user_id],
      bet_type_id: params[:bet_type_id],
      sport_id: params[:sport_id],
      wager_amount: params[:wager_amount],
      odds: params[:odds],
      win: params[:win],
      profit_loss: params[:profit_loss],
    )
    if @wager.save
      render json: { message: "Wager saved!" }, status: :created
    else
      render json: { errors: @wager.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    wager_id = params[:id]
    @wager = Wager.find_by(id: wager_id)
    render json: @wager
  end
end
