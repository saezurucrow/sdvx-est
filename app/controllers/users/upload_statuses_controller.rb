class Users::UploadStatusesController < ApplicationController
  before_action :authenticate_user!

  def show
    @upload_status = UploadStatus.includes(ex_score_differences: [{ ex_score: :song }]).find(params[:id])
    redirect_to(*path) if @upload_status.nil?
    redirect_to users_mypage_path unless current_user.id == @upload_status.user_id
  end
end
