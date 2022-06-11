class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[mypage edit update]

  def mypage
    @user = current_user
    @s_puc_count = current_user.ex_scores.s_puc_count(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @s_puc_count = current_user.ex_scores.s_puc_count(params[:id])
    redirect_to users_mypage_path if @user == current_user
  end
end
