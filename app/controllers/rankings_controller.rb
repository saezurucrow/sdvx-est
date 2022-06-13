class RankingsController < ApplicationController
  def index
    @q = Song.all.page(params[:page]).ransack(params[:q])
    @songs = @q.result
  end

  def show
    @song = Song.find(params[:id])
    @ranking = ExScore.where(song_id: @song.id).includes(:user).sort_by { |ex_score| -ex_score.ex_score }
  end

  def max
    @users = User.all.includes(%i[ex_scores upload_statuses]).sort_by { |user| -user.ex_scores.s_puc_count(user.id) }
  end
end
