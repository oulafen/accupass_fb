class UsersController < ApplicationController
  def login
    @user= User.new
  end

  def register
    @user= User.new
  end

  def welcome

  end


  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :welcome
      #, :notice => '注册成功'
    else
      render :register
    end
  end

  def create_login_session
    user=User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token]=user.token
      redirect_to welcome, :notice => '登录成功'
    else
      #flash[:error]='无效的用户名或密码'
      #puts 'user------>'

      render :login, :notice =>'无效的用户名或密码'
    end
  end

end

