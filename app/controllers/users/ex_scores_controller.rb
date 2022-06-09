class Users::ExScoresController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  # スコア非公開の設定をしている場合ユーザー詳細にリダイレクトするように

  # レベル選択
  def index
    @user = User.find(params[:user_id])
    @ex_scores = ExScore.where(user_id: params[:user_id])
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
    flash.now[:notice] = 'スコアが登録されました'
    redirect_to users_upload_status_path(upload_status_id)
  end
end
