class User < ActiveRecord::Base
  has_secure_password
  validates :name , :presence => true, :uniqueness => {:case_sensitive => false}
  validates :forgot_pw_answer , :presence => true
  validates :forgot_pw_question , :presence => true

  attr_accessible :name, :password, :password_confirmation, :forgot_pw_question, :forgot_pw_answer, :type


end
