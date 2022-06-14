class Admins::SongsController < ApplicationController
  before_action :is_admin!
  layout 'admin_application'

  def index
    @q = Song.all.order(id: 'DESC').ransack(params[:q])
    @result_count = @q.result.count
    @songs = @q.result.page(params[:page])
  end

  def new
    @song = Song.new
  end

  def create
    # TODO: modelでバリデーション する
    if Song.where(name: params[:song][:name], level: params[:song][:level], difficult: params[:song][:difficult]).count > 0
      flash.now[:alert] = '同じ楽曲データが存在します'
      @song = Song.new
      render :new
      return
    end

    if params[:song][:level] == 0
      flash.now[:alert] = '難易度0は使用できません'
      @song = Song.new
      render :new
      return
    end

    if params[:song][:max_ex_score] == 0
      flash.now[:alert] = '理論値0は使用できません'
      @song = Song.new
      render :new
      return
    end

    song = Song.new(song_params)
    if song.save!
      flash.now[:notice] = '作成しました'
      redirect_to admins_songs_path
    else
      flash.now[:alert] = '作成できませんでした'
      redirect_to admins_songs_path
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    song = Song.find(params[:id])
    if song.update(song_params)
      flash.now[:notice] = '更新しました'
      redirect_to admins_songs_path
    else
      flash.now[:alert] = '更新できませんでした'
      redirect_to admins_songs_path
    end
  end

  def destroy
    song = Song.find(params[:id])
    if song.destroy!
      flash.now[:notice] = '削除しました'
      redirect_to admins_songs_path
    else
      flash.now[:alert] = '削除できませんでした'
      redirect_to admins_songs_path
    end
  end

  private

  def is_admin!
    redirect_to root_path unless current_user.is_admin
  end

  def song_params
    params.require(:song).permit(:name, :level, :difficult, :max_ex_score)
  end
end
