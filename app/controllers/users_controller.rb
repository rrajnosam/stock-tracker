class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @following = current_user.friends
  end

  def search
    if params[:query].present?
      @query_results = User.search(params[:query])
      @query_results = current_user.exclude_current_user(@query_results)
      if @query_results
        respond_to do |format|
          format.js{render partial: 'users/friend_results.js.erb'}
        end

      else
        respond_to do |format|
          flash.now[:alert] = "No such potential friend exists"
          format.js{render partial: "users/friend_results.js.erb"}
        end

      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a name or email"
        format.js{render partial: "users/friend_results.js.erb"}
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
end
