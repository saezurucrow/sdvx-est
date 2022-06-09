class HomesController < ApplicationController
  def index
    @all_user_count = User.all.count
    @song_user_count = Song.all.count
  end
end
