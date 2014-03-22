class Bid < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :bid_status

  def self.update_bids(user,bids)
    Bid.delete_all(:user => user)
    bids.each do |bid|
      Bid.create(bid)
    end
  end
end
