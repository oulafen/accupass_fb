class Activity < ActiveRecord::Base
  attr_accessible :user, :active_name, :active_status

  def self.update_activities(user,activities)
    #if !Activity.where(:user=>user).nil?
      Activity.delete_all(:user => user)
    #end
    activities.each do |activity|
      Activity.create(activity)
    end
  end
end
