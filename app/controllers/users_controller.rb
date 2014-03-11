class UsersController < ApplicationController
  def login
  end

  def register
    @user= User.new
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
      render :register
    end
  end
end
