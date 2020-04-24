class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @following = current_user.friends
  end

  def search
    if params[:friend].present?
      @f = params[:friend]
      if @f
        respond_to do |format|
          format.js{render partial: 'users/friend_results.js.erb'}
        end

      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid ticker symbol"
          format.js{render partial: "users/friend_results.js.erb"}
        end

      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a ticker symbol"
        format.js{render partial: "users/friend_results.js.erb"}
      end
    end
  
  end
end
