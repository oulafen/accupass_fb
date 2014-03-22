class BidPeople < ActiveRecord::Base
  attr_accessible :activity_name, :bid_name, :user, :name, :phone, :price

  def self.update_bid_people(user,bid_people)
    if !BidPeople.where(:user=>user).nil?
      BidPeople.delete_all(:user => user)
    end
    bid_people.each do |bid_person|
      BidPeople.create(bid_person)
    end
  end
end
