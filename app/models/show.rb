class Show < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :name, :phone, :price

  def self.update_show_winner(bid_winner)
    Show.delete_all
    show = Show.new(:activity_name=>bid_winner[:activity_name],:bid_name=>bid_winner[:bid_name],
    :user=>bid_winner[:user],:name=>bid_winner[:name],:phone=>bid_winner[:phone],:price=>bid_winner[:price])
    show.save
  end
end
