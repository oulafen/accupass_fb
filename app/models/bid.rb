class Bid < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :bid_status

  def self.update_bids(user,bids)
    if !Bid.where(:user=>user).nil?
      Bid.delete_all(:user => user)
    end
    bids.each do |bid|
      #bid=Bid.new(:activity_name=>b[:activity_name],:)
      Bid.create(bid)
    end
  end
end
