# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    @last_song_updated_at = Song.last.updated_at.to_s(:date_jp)
  end

  def howto; end

  def support; end
end
