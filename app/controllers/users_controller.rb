class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:process_phone_login ]
  skip_before_filter :verify_authenticity_token,:only=>[:process_phone_data]
  require 'will_paginate/array'

  def login
  end

  def register
    @user = User.new
  end

  def user_index
    @user = session[:name]
    @activities = reconstruct_activities(@user)
    session[:present_activity_name]=nil
    @pages = @activities.paginate :page => params[:page], :per_page => 10
  end

  def bid_list
    @user = session[:name]
    @bids = reconstruct_bids(params[:activity_name],@user)
    session[:present_activity_name] = params[:activity_name]
    @pages = @bids.paginate :page => params[:page], :per_page => 10
  end

  def sign_up_list
    @user = session[:name]
    @sign_ups = reconstruct_sign_ups(params[:activity_name],@user)
    session[:present_activity_name] = params[:activity_name]
    @pages = @sign_ups.paginate :page => params[:page], :per_page => 10

  end

  def bid_detail
    @user = session[:name]
    session[:present_bid_name] = params[:present_bid_name]
    @winner = winner
    @pages = present_bid_people.paginate :page => params[:page], :per_page => 10

  end

  def price_statistics
    @user = session[:name]
    @winner = winner
    @pages = statistics.paginate :page => params[:page], :per_page => 10
  end

  def winner
    BidResult.where(:user=>session[:name],:activity_name=>session[:present_activity_name],
                             :bid_name=> session[:present_bid_name])
  end

  def present_bid_people
    BidPeople.where(:user=>session[:name],:activity_name=>session[:present_activity_name],
                           :bid_name=> session[:present_bid_name])
  end

  def statistics
    bid_people = present_bid_people
    bps=[]
    bid_people.each do |b|
      bp={}
      bp[:price]=b[:price]
      bp[:num]=bid_people.where(:price=>b.price).length
      bps.push(bp)
    end
    bps
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:name] = params[:user][:name]
      redirect_to :user_index
    else
      render :register
    end
  end

  def reconstruct_activities(user)
    activities = Activity.where(:user=>user)
    new_acts=[]
    activities.each do |a|
      act={}
      act[:id] = new_acts.length+1
      act[:name] = a.active_name
      act[:bm_num] = SignUp.where(:user=>user, :activity_name=>a.active_name).length
      act[:jj_num] = Bid.where(:user=>user, :activity_name=>a.active_name).length
      new_acts.push(act)
    end
    new_acts
  end

  def reconstruct_bids(act_name,user)
    bids=Bid.where(:user=>user, :activity_name=>act_name )
    new_bids=[]
    bids.each do |b|
      bid={}
      bid[:id] = new_bids.length+1
      bid[:name] = b.bid_name
      bid[:bm_num] = SignUp.where(:user=>user, :activity_name=>act_name).length
      bid[:jj_num] = BidPeople.where(:user=>user, :activity_name=>act_name, :bid_name=>b.bid_name).length
      new_bids.push(bid)
    end
    new_bids
  end

  def reconstruct_sign_ups(act_name,user)
    sign_ups=SignUp.where(:user=>user, :activity_name=>act_name )
    new_sign_ups=[]
    sign_ups.each do |s|
      sign_up={}
      sign_up[:id] = new_sign_ups.length+1
      sign_up[:name] = s.name
      sign_up[:phone] = s.phone
      new_sign_ups.push(sign_up)
    end
    new_sign_ups
  end

  def create_login_session
    login_person = User.find_by_name(params[:user][:name])
    if login_person && login_person.authenticate(params[:user][:password])
      if login_person[:login_type]=='admin'
        redirect_to :manager_index
      else
        session[:name] = params[:user][:name]
        redirect_to :user_index
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

