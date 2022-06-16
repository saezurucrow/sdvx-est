class RankingsController < ApplicationController
  def index
    @q = Song.all.order(id: 'DESC').ransack(params[:q])
    @result_count = @q.result.count
    @songs = @q.result.page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @ranking = ExScore.where(song_id: @song.id).order(song_id: 'DESC').includes(:user).sort_by { |ex_score| -ex_score.ex_score }
  end

  def max
    @users = User.includes(%i[ex_scores upload_statuses]).where.not(upload_statuses: { id: nil }).select do |x|
               x.ex_scores.s_puc_count(x.id) > 0
             end.sort_by { |user| -user.ex_scores.s_puc_count(user.id) }
  end
end
