# frozen_string_literal: true

module Users
  class UploadStatusesController < ApplicationController
    before_action :authenticate_user!

    def index
      @upload_statuses = @upload_statuses = UploadStatus.where(user_id: current_user.id).order(id: 'DESC').page(params[:page])
    end

    def show
      @upload_status = UploadStatus.includes(ex_score_differences: [{ ex_score: :song }]).find(params[:id])
      redirect_to(*path) if @upload_status.nil?
      redirect_to users_mypage_path unless current_user.id == @upload_status.user_id
    end
  end
end
