class User < ActiveRecord::Base
  has_secure_password
  validates :name , :presence => true, :uniqueness => {:case_sensitive => false}
  validates :forgot_pw_answer , :presence => true
  validates :forgot_pw_question , :presence => true

  attr_accessible :name, :password, :password_confirmation, :forgot_pw_question, :forgot_pw_answer, :token

  before_create{generate_token(:token)}

  def generate_token(column)
    begin
      self[column]=SecureRandom.urlsafe_base64
    end while User.exists?(column=>self[column])
  end


end
