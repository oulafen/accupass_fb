class Activity < ActiveRecord::Base
  attr_accessible :user, :active_name, :active_status

  def self.update_activities(user,activities)
    Activity.delete_all(:user => user)

    activities.each do |activity|
      Activity.create(activity)
    end
  end
end
