# frozen_string_literal: true

module Admins
  class SongsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin!
    layout 'admin_application'

    def index
      @q = Song.all.order(id: 'DESC').ransack(params[:q])
      @result_count = @q.result(distinct: true).count
      @songs = @q.result(distinct: true).page(params[:page])
    end

    def new
      @song = Song.new
    end

    def create
      # TODO: modelでバリデーション する
      if Song.where(name: params[:song][:name], level: params[:song][:level],
                    difficult: params[:song][:difficult]).count.positive?
        flash.now[:alert] = '同じ楽曲データが存在します'
        @song = Song.new
        render :new
        return
      end

      if params[:song][:level].to_i.zero?
        flash.now[:alert] = '難易度0は使用できません'
        @song = Song.new
        render :new
        return
      end

      if params[:song][:max_ex_score].to_i.zero?
        flash.now[:alert] = '理論値0は使用できません'
        @song = Song.new
        render :new
        return
      end

      song = Song.new(song_params)
      if song.save!
        flash.now[:notice] = '作成しました'
      else
        flash.now[:alert] = '作成できませんでした'
      end
      redirect_to admins_songs_path
    end

    def edit
      @song = Song.find(params[:id])
    end

    def update
      song = Song.find(params[:id])
      if song.update(song_params)
        flash.now[:notice] = '更新しました'
      else
        flash.now[:alert] = '更新できませんでした'
      end
      redirect_to admins_songs_path
    end

    def destroy
      song = Song.find(params[:id])
      if song.destroy!
        flash.now[:notice] = '削除しました'
      else
        flash.now[:alert] = '削除できませんでした'
      end
      redirect_to admins_songs_path
    end

    private

    def is_admin!
      redirect_to root_path unless current_user.is_admin
    end

    def song_params
      params.require(:song).permit(:name, :level, :difficult, :max_ex_score, :delete_flag)
    end
  end
end
