class ExScoresController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  # レベル選択
  def level_select; end

  # レベル別ExScore一覧
  def level_show; end

  # ExScore登録ページ
  def new; end

  # ExScore登録処理
  def create
    ex_score = params[:exscore]

    # TODO: CSVで送られてきた場合この処理を省略する
    ex_score_csv = ExScore.conversion_csv(ex_score)

    # csvがscoreデータかどうか
    unless ExScore.confirm_score_csv?(ex_score_csv)
      flash.now[:alert] = 'scoreデータの形式が一致しません'
      render :new
    end

    # ExScore登録
    ExScore.insert_ex_scores(ex_score_csv, current_user)
  end
end
