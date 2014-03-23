class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:process_phone_login ]
  skip_before_filter :verify_authenticity_token,:only=>[:process_phone_data]

  def login
  end

  def register
    @user = User.new
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

  def manager_index
    session[:success]=''
    @user = User.where(:login_type => 'user')
    @pages_user = @user.paginate :page => params[:page], :per_page => 10
  end

  def logout
    session[:name] = nil
  end

  def process_phone_login
    user = User.find_by_name(params[:name])
    respond_to do |format|
      if user && user.authenticate( params[:password])
        format.json { render json: 'true' }
      else
        format.json { render json: 'false' }
      end
    end
  end

  def process_phone_data
    Activity.update_activities(params[:login_user],params[:activities])
    Bid.update_bids(params[:login_user],params[:bids])
    SignUp.update_sign_ups(params[:login_user],params[:sign_ups])
    BidPeople.update_bid_people(params[:login_user],params[:bid_peoples])
    BidResult.update_bid_results(params[:login_user],params[:bid_results])

    respond_to do |format|
      format.json { render json: 'true' }
    end


  end

end

