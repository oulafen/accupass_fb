class BidResult < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :name, :phone, :price, :status

  def self.update_bid_results(user,bid_results)
    if !BidResult.where(:user=>user).nil?
      BidResult.delete_all(:user => user)
    end
    bid_results.each do |bid_result|
      BidResult.create(bid_result)
    end
  end
end
