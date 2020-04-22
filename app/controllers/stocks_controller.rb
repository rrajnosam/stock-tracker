class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock != nil
        respond_to do |format|
          format.js{render partial: 'users/results.js.erb'}
        end

      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid ticker symbol"
          format.js{render partial: "users/results.js.erb"}
        end

      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a ticker symbol"
        format.js{render partial: "users/results.js.erb"}
      end


    end
  end
end
