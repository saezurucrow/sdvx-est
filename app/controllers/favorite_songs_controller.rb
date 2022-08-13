# frozen_string_literal: true

class FavoriteSongsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_song

  def create
    FavoriteSong.create!(user_id: current_user.id, song_id: @song.id)
  end

  def destroy
    favorite_song = FavoriteSong.find_by(user_id: current_user.id, song_id: @song.id)
    favorite_song.destroy
  end

  private

  def set_song
    @song ||= Song.find(params[:id])
  end
end
