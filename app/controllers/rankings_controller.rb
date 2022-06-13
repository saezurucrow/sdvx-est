class RankingsController < ApplicationController
  def index; end

  def show; end

  def max
    @users = User.all.includes(%i[ex_scores upload_statuses]).sort_by { |user| -user.ex_scores.s_puc_count(user.id) }
  end
end
