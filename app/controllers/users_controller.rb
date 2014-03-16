class UsersController < ApplicationController
  def login
  end

  def manager_index
    @user = User.where(:login_type => 'user')
    @pages_user = @user.paginate :page => params[:page], :per_page => 10
  end

  def add_user
    @user = User.new
  end


  def register
    @user = User.new
  end

  def welcome
    @user = session[:name]
  end

  def change_password
    @user = User.new
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

  def save_user
    puts
    @user = User.new(params[:user])
    if @user.save
      redirect_to :add_user
    else
      render :add_user
    end
  end

  def create_login_session
    login_person = User.find_by_name(params[:user][:name])

    if login_person && login_person.authenticate(params[:user][:password])
      if login_person[:login_type]=='admin'
        redirect_to :manager_index
      else
        session[:name] = params[:user][:name]
        redirect_to :welcome
      end
    else
      flash.now[:error] = '无效的用户名或密码'
      render :login
    end
  end

  def del_user
    User.find_by_id(params[:id]).delete
    redirect_to :manager_index
  end

  def logout
    session[:name] = nil
  end


end

