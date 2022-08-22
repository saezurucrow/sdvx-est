# frozen_string_literal: true

class FavoriteSong < ApplicationRecord
  belongs_to :user
  belongs_to :song

  validates_uniqueness_of :song_id, scope: :user_id
end
