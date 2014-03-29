class Bid < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :bid_status

  def self.update_bids(user,bids)
    Bid.delete_all(:user => user)
    bids.each do |(key,value)|
      Bid.create(value)
    end
  end

  def self.get_present_bid
    Bid.where(:user=>session[:name],:bid_status=>'yellow')
  end
end
