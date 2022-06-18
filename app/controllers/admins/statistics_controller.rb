# frozen_string_literal: true

module Admins
  class StatisticsController < ApplicationController
    before_action :is_admin!
    layout 'admin_application'

    def index
      @user_count = User.count
      @song_count = Song.count
      @ex_score_count = ExScore.count
      @ex_score_difference_count = ExScoreDifference.count
      @upload_status_count = UploadStatus.count
    end

    private

    def is_admin!
      redirect_to root_path unless current_user.is_admin
    end
  end
end
