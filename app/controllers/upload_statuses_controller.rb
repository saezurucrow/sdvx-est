class UploadStatusesController < ApplicationController
  before_action :authenticate_user!

  def show
    @upload_status = UploadStatus.includes(ex_score_differences: [{ ex_score: :song }]).find(params[:id])
    # TODO: 404 not foundページに飛ばしたい
    redirect_to root_path if @upload_status.nil?
    redirect_to users_mypage_path unless current_user.id == @upload_status.user_id
  end
end
