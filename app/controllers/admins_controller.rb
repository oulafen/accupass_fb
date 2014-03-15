class AdminsController < ApplicationController
  def manager_index
    @user=User.all
  end

  def add_user
  end
end
