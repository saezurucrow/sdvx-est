# frozen_string_literal: true

module Admins
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin!
    layout 'admin_application'

    def index
      @q = User.all.order(id: 'ASC').ransack(params[:q])
      @result_count = @q.result(distinct: true).count
      @users = @q.result(distinct: true).page(params[:page])
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
end
