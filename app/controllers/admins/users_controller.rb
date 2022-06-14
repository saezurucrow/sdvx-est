class Admins::UsersController < ApplicationController
  before_action :is_admin!
  layout 'admin_application'

  def index
    @q = User.all.ransack(params[:q])
    @result_count = @q.result.count
    @users = @q.result.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admins_path
  end

  private

  def is_admin!
    redirect_to root_path unless current_user.is_admin
  end

  def user_params
    params.require(:user).permit(:username, :score_opened, :ranking_opened, :deleted)
  end
end
