class UsersController < ApplicationController
  def login
  end

  def register
    @user=params[:user]
  end

  def welcome

  end

  def errors

  end


  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :welcome,:notice=> '注册成功'
    else
      redirect_to :register,:notice=>'注册信息有误'
    end
  end
end
