class WagersController < ApplicationController
  before_action :authenticate_user

  def index
    @wagers = current_user.wagers
    render json: @wagers.as_json(include: [:sport, :bet_type, :user])
  end

  def show
    wager_id = params[:id]
    @wager = current_user.wagers.find_by(id: wager_id)

    if @wager
      render json: @wager.as_json
    else
      render json: { errors: "Wager does  not exist" }, status: :bad_request
    end
  end

  def create
    prof_loss_calc = 0.00
    if params[:win] == "true"
      if params[:odds].to_i < 0
        prof_loss_calc = params[:wager_amount].to_i / ((-1 * params[:odds].to_i) / 100.00)
      elsif params[:odds].to_i > 0
        prof_loss_calc = (params[:wager_amount].to_i * ((params[:odds].to_i / 100.00).to_f))
      end
    elsif params[:win] == "false"
      prof_loss_calc = (-1 * params[:wager_amount].to_i)
    end

    @wager = Wager.new(
      user_id: current_user.id,
      bet_type_id: params[:bet_type_id],
      sport_id: params[:sport_id],
      wager_amount: params[:wager_amount],
      odds: params[:odds],
      win: params[:win],
      profit_loss: prof_loss_calc,
    )
    if @wager.save
      render json: { message: "Wager saved!" }, status: :created
    else
      render json: { errors: @wager.errors.full_messages }, status: :unprocessable_entity
    end
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
