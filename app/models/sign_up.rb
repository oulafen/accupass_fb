class SignUp < ActiveRecord::Base
  attr_accessible :user, :activity_name, :name, :phone

  def self.update_sign_ups(user,sign_ups)
    SignUp.delete_all(:user => user)
    sign_ups.each do |sign_up|
      SignUp.create(sign_up)
    end
  end
end
