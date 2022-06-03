class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[mypage edit update]

  def mypage
    @user = current_user
  end

  def show; end

  def edit; end

  def update; end
end
