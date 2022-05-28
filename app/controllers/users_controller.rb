class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @uesr = current_user
  end

  def show
  end

  def edit
  end

  def update
  end
end
