class BidPeople < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :name, :phone, :price

  def self.update_bid_people(user,bid_people)
    BidPeople.delete_all(:user => user)
    bid_people.each do |(key,value)|
      BidPeople.create(value)
    end
  end
end
