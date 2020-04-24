class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
    stock = Stock.new_lookup(params[:ticker])
    stock.save
    end
    @user_stock = UserStock.create(user: current_user,stock: stock)
    flash[:notice]="You have successfully added #{stock.ticker} to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock_to_kill = Stock.find(params[:id])
    UserStock.where(user_id: current_user.id, stock_id: stock_to_kill.id).first.destroy
    flash[:notice] ="Successfully removed #{stock_to_kill.ticker}"
    redirect_to my_portfolio_path
  end
end
