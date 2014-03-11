class User < ActiveRecord::Base

  attr_accessible :name, :password, :password_confirmation, :forgot_pw_question, :forgot_pw_answer

end
