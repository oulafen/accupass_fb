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
    login_person=login_validate(params[:user])
    if login_person
      if Admin.find_by_name(login_person.name)
        redirect_to "/admins/manager_index"
      else
        session[:name] = params[:user][:name]
        redirect_to :welcome
      end
    else
      flash.now[:error] = '无效的用户名或密码'
      render :login
    end
  end

  def login_validate(user)
    @admin=Admin.find_by_name(user[:name])
    @user=User.find_by_name(user[:name])
    if @admin && @admin.password==user[:password]
      return @admin
    end
    if @user && @user.authenticate(user[:password])
      return @user
    end
  end

    def logout
      session[:name]=nil
    end


end

