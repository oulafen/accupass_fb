class BidResult < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :name, :phone, :price, :status

  def self.update_bid_results(user,bid_results)
    BidResult.delete_all(:user => user)

    bid_results.each do |bid_result|
      BidResult.create(bid_result)
    end
  end
end
