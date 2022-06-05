class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[mypage edit update]

  def mypage
    @user = current_user
    @s_puc_count = current_user.ex_scores.s_puc_count(current_user.id)
  end

  def show; end
end
