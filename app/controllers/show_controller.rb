class ShowController < ApplicationController
  skip_before_filter :verify_authenticity_token

  require 'will_paginate/array'

  def show
    @activity_is_going = !Activity.where(:user=>session[:name],:active_status=>'yellow')[0].nil?
    @present_bid = Bid.where(:user=>session[:name],:bid_status=>'yellow')
    @is_starting=!@present_bid[0].nil?
    if @is_starting
      bid_people= BidPeople.where(:bid_name=>@present_bid[0].bid_name,:user=>session[:name],:activity_name=>@present_bid[0].activity_name)
      @jj_num = bid_people.length
      @bm_num = SignUp.where(:user=>session[:name],:activity_name=>@present_bid[0].activity_name).length

      @bid_status = @present_bid.at(0).bid_status
      @pages_people_shows = bid_people.paginate :page => params[:page], :per_page => 10

    else
      @winner = Show.find(:all)
    end
  end

  def show_winner_data
    if params[:bid_winner]=='fail'
      Show.delete_all
    else
      Show.update_show_winner(params[:bid_winner])
    end

    respond_to do |format|
      format.json { render json: 'true' }
    end
  end

end
