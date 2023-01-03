# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    @q = Song.includes(:favorite_songs).order(id: 'DESC').ransack(params[:q])
    @result_count = @q.result(distinct: true).count
    @songs = @q.result(distinct: true).page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @ranking = ExScore.where(song_id: @song.id).order(song_id: 'DESC').includes(:user).sort_by do |ex_score|
      -ex_score.ex_score
    end
  end

  # TODO: Top,Top Player,Your Score,Your No. のソート実装
  def score_top
    @q = Song.includes(:favorite_songs, ex_scores: [:user]).order(id: 'DESC').ransack(params[:q])
    @result_count = @q.result(distinct: true).count
    @songs = @q.result(distinct: true).page(params[:page])
  end

  def max
    redirect_to root_path unless redis.exists('max_ranking')

    @rankings = []
    @ranks = []
    rank = 1
    prev_max_count = 0

    ranking = redis.zrevrange('max_ranking', 0, -1, with_scores: true)
    ranking.each.with_index do |r, index|
      @rankings.push({ username: r[0], max_count: r[1] })
      if index === 0
        @ranks.push(rank)
        prev_max_count = r[1]
      elsif prev_max_count == r[1]
        @ranks.push(rank)
      else
        rank = index + 1
        @ranks.push(rank)
        prev_max_count = r[1]
      end
    end
  end

  private

  def redis
    @redis ||= Redis.new(url: ENV['REDIS_URL'] || 'redis://redis:6379')
  end
end
