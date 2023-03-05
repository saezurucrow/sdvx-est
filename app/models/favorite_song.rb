# frozen_string_literal: true

class FavoriteSong < ApplicationRecord
  belongs_to :user
  belongs_to :song

  validates_uniqueness_of :song_id, scope: :user_id

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id song_id updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[song user]
  end
end
