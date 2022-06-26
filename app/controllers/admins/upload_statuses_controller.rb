# frozen_string_literal: true

module Admins
  class UploadStatusesController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin!
    layout 'admin_application'

    def index
      @q = UploadStatus.all.includes(:user).order(id: 'DESC').ransack(params[:q])
      @result_count = @q.result.count
      @upload_statuses = @q.result.page(params[:page])
    end

    def show
      @upload_status = UploadStatus.includes(ex_score_differences: [{ ex_score: :song }]).find(params[:id])
    end

    private

    def is_admin!
      redirect_to root_path unless current_user.is_admin
    end
  end
end
