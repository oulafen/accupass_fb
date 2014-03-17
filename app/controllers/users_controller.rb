class UsersController < ApplicationController
  def login
  end

  def manager_index
    session[:success]=''
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
    @user = User.find_by_name(params[:name])
    session[:current_change_name] = params[:name]
  end

  def forgot_pw_1
    if params[:user][:name]==''
      flash.now[:notice] = '账号不能为空'
    end
    user = User.find_by_name(params[:user][:name])
    if user
      session[:forgot_pw_user_name] = params[:user][:name]
      redirect_to :forgot_2
    else
      render :forgot_1
    end
  end

  def forgot_2
    @user = User.find_by_name(session[:forgot_pw_user_name])

  end

  def update_password
    judge_pw=judge_change_password(params[:user])
    @user=User.find_by_name(session[:current_change_name])
    if judge_pw=='authorized'
       @user.password = params[:user][:password]
       @user.password_confirmation = params[:user][:password_confirmation]
       if @user.save
          session[:success]='true'
          render :change_password
       end
    else
      flash.now[:notice] = judge_pw=='empty' ? '输入不能为空' : '两次密码输入不一致'
      render :change_password
    end
  end

  def judge_change_password(user)
    if user[:password]=='' || user[:password_confirmation]==''
      return 'empty'
    else if user[:password]!=user[:password_confirmation]
      return 'unequal'
    else
      return 'authorized'
      end
    end
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

