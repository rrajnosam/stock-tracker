class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
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

  def exclude_current_user(array)
    return array.reject{|user| user.id == self.id}
  end

  def self.search(params)
    params.strip!
    search_results = (User.email_search(params) + User.first_name_search(params) + User.last_name_search(params)).uniq
    if search_results
      return search_results
    else
      return nil
    end
  end

  def self.email_search(query)
    return User.match("email", query)
  end

  def self.first_name_search(query)
    return User.match("first_name", query)
  end

  def self.last_name_search(query)
    return User.match("last_name", query)
  end

  def self.match(field_name,query)
    return User.where("#{field_name} like ?", "%#{query}%")
  end

  def already_following?(friend_id)
    return self.friends.where(id: friend_id).exists?
  end

end
