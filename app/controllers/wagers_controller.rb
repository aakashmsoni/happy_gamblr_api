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

  def update
    wager_id = params[:id]
    @wager = Wager.find_by(id: wager_id)
    @wager.update(
      user_id: @wager.user_id,
      bet_type_id: params[:bet_type_id] || @wager.bet_type_id,
      sport_id: params[:sport_id] || @wager.sport_id,
      wager_amount: params[:wager_amount] || @wager.wager_amount,
      odds: params[:odds] || @wager.odds,
      win: params[:win] || @wager.win,
      profit_loss: params[:profit_loss] || @wager.profit_loss,
    )

    if @wager.save
      render json: @wager
    else
      render json: { errors: @wager.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @wager = Wager.find_by(id: params[:id])
    @wager.destroy
    render json: { message: "Successfully deleted!" }
  end
end
