class User < ActiveRecord::Base

  validates :name , :presence => true
  validates :password , :presence => true
  validates :password_confirmation , :presence => true
  validates :forgot_pw_answer , :presence => true
  validates :forgot_pw_question , :presence => true
  has_secure_password

  attr_accessible :name, :password, :password_confirmation, :forgot_pw_question, :forgot_pw_answer

end
