class Activity < ActiveRecord::Base
  attr_accessible :user, :active_name, :active_status

  def self.update_activities(user,activities)
    if !Activity.where(:user=>user).nil?
      Activity.delete_all(:user => user)
    end
    activities.each do |a|
      #activity=Activity.new(:active_name=>a[:active_name],:active_status=>a[:active_name],:user=>user)
      #activity.save
      Activity.create(a)
    end
  end
end
