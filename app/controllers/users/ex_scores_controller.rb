# frozen_string_literal: true

module Users
  class ExScoresController < ApplicationController
    before_action :authenticate_user!, only: %i[new create]

    def index
      @user = User.find(params[:user_id])
      if @user != current_user && @user.score_opened == 'privated'
        redirect_to users_mypage_path,
                    alert: 'scoreが非公開に設定されています'
      end

      @q = ExScore.where(user_id: params[:user_id]).order(song_id: 'DESC').includes(song: [:favorite_songs]).where.not(songs: { delete_flag: 1 }).ransack(params[:q])
      # FIXME: ソートがPGではうまくいかないので回避
      if params[:q].blank?
        @result_count = @q.result(distinct: true).count
        @ex_scores = @q.result(distinct: true).page(params[:page])
      elsif params[:q][:s].blank?
        @result_count = @q.result(distinct: true).count
        @ex_scores = @q.result(distinct: true).page(params[:page])
      elsif %w[song_name song_difficult song_level].any? { |t| params[:q][:s].include?(t) }
        @result_count = @q.result.count
        @ex_scores = @q.result.page(params[:page])
      else
        @result_count = @q.result(distinct: true).count
        @ex_scores = @q.result(distinct: true).page(params[:page])
      end
    end

    def show; end

    # ExScore登録ページ
    def new; end

    # ExScore登録処理
    def create
      # TODO: CSVで送られてきた場合この処理を省略する
      ExScore.conversion_csv(params[:ex_score], current_user.id)

      # csvがscoreデータかどうか
      unless ExScore.confirm_score_csv?("tmp/ex_score_#{current_user.id}.csv")
        flash.now[:alert] = 'scoreデータの形式が一致しません'
        render :new
        return
      end

      # ExScore登録
      begin
        upload_status_id = ExScore.insert_ex_scores("tmp/ex_score_#{current_user.id}.csv", current_user)
      rescue StandardError => e
        flash.now[:alert] = e
        File.delete("tmp/ex_score_#{current_user.id}.csv")
        render :new
        return
      end

      File.delete("tmp/ex_score_#{current_user.id}.csv")

      # 差分詳細ページへ遷移
      redirect_to users_upload_status_path(upload_status_id), notice: 'スコアが登録されました'
    end
  end
end
