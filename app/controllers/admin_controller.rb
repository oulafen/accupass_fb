class AdminController < ApplicationController

  def manager_index
    if !session[:name]
      redirect_to :root
    end
    if session[:name]
      @pages_user = reconstruct_user_list.paginate :page => params[:page], :per_page => 10
    end
  end

  def add_user
    @user = User.new
  end

  def change_password
    @user = User.find_by_name(params[:name])
    session[:current_change_name] = params[:name]
  end

  def forgot_pw_1
    user_is_find = User.find_by_name(params[:user][:name])

    if params[:user][:name]==''
      flash.now[:notice] = '账号不能为空'
    end
    if user_is_find
      session[:forgot_pw_user_name] = params[:user][:name]
      redirect_to :forgot_2, :method=>'post'
    end
    if !user_is_find
      render :forgot_1
    end
  end

  def forgot_2
    @user = User.find_by_name(session[:forgot_pw_user_name])
  end

  def judge_q_and_a
    @user=User.find_by_name(session[:forgot_pw_user_name])
    if @user.forgot_pw_answer==params[:user][:forgot_pw_answer]
      redirect_to :forgot_3
    end
    if @user.forgot_pw_answer!=params[:user][:forgot_pw_answer]
      flash.now[:notice]='忘记密码答案错误'
      render :forgot_2
    end
  end

  def reconstruct_user_list
    temp_users = User.where(:login_type => 'user')
    users=[]
    temp_users.each do |user|
      u={}
      u[:id]=user.id
      u[:index]=users.length+1
      u[:name]=user.name
      users.push(u)
    end
    users
  end

  def update_reset_password
    judge_pw = judge_change_password(params[:user])
    user = User.find_by_name(session[:forgot_pw_user_name])
    if judge_pw == 'unequal' && judge_pw != 'empty'
      flash.now[:notice] = '两次密码输入不一致'
      render :forgot_3
    end
    if judge_pw != 'unequal' && judge_pw == 'empty'
           flash.now[:notice] = '输入不能为空'
           render :forgot_3
    end
    if judge_pw != 'unequal' && judge_pw != 'empty'
       session[:name] = user.name
       user.password = params[:user][:password]
       user.password_confirmation = params[:user][:password_confirmation]
       user.save
       redirect_to :user_index
     end
  end

  def update_password
    judge_pw=judge_change_password(params[:user])
    @user=User.find_by_name(session[:current_change_name])
    if judge_pw=='authorized'
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        session[:success]='true'
      end
    end
    if judge_pw!='authorized'
      flash.now[:notice] = judge_pw=='empty' ? '输入不能为空' : '两次密码输入不一致'
    end
    render :change_password
  end

  def judge_change_password(user)
    if user[:password]=='' || user[:password_confirmation]==''
      return 'empty'
    end
    if user[:password]!='' && user[:password_confirmation]!='' && user[:password]!=user[:password_confirmation]
      return 'unequal'
    end
    if user[:password]!='' && user[:password_confirmation]!='' && user[:password]==user[:password_confirmation]
      return 'authorized'
    end
  end

  def save_user
    @user = User.new(params[:user])
    if @user.save
      redirect_to :add_user
    else
      render :add_user
    end
  end

  def del_user
    User.find_by_name(params[:name]).delete
    if !Activity.find_by_user(params[:name]).nil?
      BidResult.find_by_user(params[:name]).delete
      Bid.find_by_user(params[:name]).delete
      BidPeople.find_by_user(params[:name]).delete
      SignUp.find_by_user(params[:name]).delete
      Activity.find_by_user(params[:name]).delete
    end

    redirect_to :manager_index
  end

end
