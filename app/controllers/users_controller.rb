class UsersController < ApplicationController
  def login
  end

  def register
    @user= User.new
  end

  def welcome
    @user = session[:name]

  end


  def create
    @user = User.new(params[:user])
    if @user.save
      session[:name] = params[:user][:name]
      redirect_to :welcome
    else
      render :register
    end
  end

  def create_login_session
    @user=User.find_by_name(params[:user][:name])

    if @user && @user.authenticate(params[:user][:password])
      session[:name] = params[:user][:name]
      redirect_to :welcome
    else
      flash.now[:error]= '无效的用户名或密码'
      render :login
    end
  end

  def logout
    session[:name]=nil
  end
end

