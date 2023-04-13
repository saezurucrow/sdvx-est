# frozen_string_literal: true

module Admins
  class UploadStatusesController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin!
    layout 'admin_application'

    def index
      @q = UploadStatus.all.includes(:user).order(id: 'DESC').ransack(params[:q])
      # FIXME: ソートがPGではうまくいかない
      @result_count = @q.result(distinct: true).count
      @upload_statuses = @q.result(distinct: true).page(params[:page])
    end

    def show
      @upload_status = UploadStatus.includes(ex_score_differences: [{ ex_score: :song }]).find(params[:id])
    end

    def destroy
      # UploadStatus.find(id).ex_score_differences分繰り返す
      upload_status_id = params[:id]

      UploadStatus.find(upload_status_id).ex_score_differences.each do |ex_score_difference|
        ex_score_id = ex_score_difference.ex_score_id

        # ex_score_differenceの削除
        ex_score_difference.delete

        # ex_scoreの削除
        ExScore.find(ex_score_id).delete
      rescue ActiveRecord::RecordNotFound => e
        next
      end

      # UploadStatusの削除
      if UploadStatus.find(upload_status_id).delete
        flash.now[:notice] = '削除しました'
      else
        flash.now[:alert] = '削除できませんでした'
      end

      redirect_to admins_upload_statuses_path
    end

    private

    def is_admin!
      redirect_to root_path unless current_user.is_admin
    end
  end
end
