class SignUp < ActiveRecord::Base
  attr_accessible :user, :activity_name, :name, :phone

  def self.update_sign_ups(user,sign_ups)
    if !SignUp.where(:user=>user).nil?
      SignUp.delete_all(:user => user)
    end
    sign_ups.each do |sign_up|
      SignUp.create(sign_up)
    end
  end
end
