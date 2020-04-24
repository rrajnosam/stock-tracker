class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def already_tracking?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    if stock
      return stocks.where(id:stock.id).exists?
    else
      return false
    end
  end

  def under_ten?
    stocks.count <10
  end


  def can_track_stock?(ticker_symbol)
    if under_ten? && !already_tracking?(ticker_symbol)

      return true
    end
  end

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      "Anonymous"
    end

  end

end
