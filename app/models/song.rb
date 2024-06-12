# frozen_string_literal: true

class Song < ApplicationRecord
  has_many :ex_scores
  has_many :ex_score_differences
  has_many :favorite_songs, dependent: :destroy

  enum delete_flag: {
    active: 0,
    deleted: 1
  }

  enum difficult: {
    NOV: 0,
    ADV: 1,
    EXH: 2,
    INF: 3,
    GRV: 4,
    MXM: 5,
    HVN: 6,
    VVD: 7,
    XCD: 8
  }

  # TODO: ちゃんとDBから取得したい
  def self.array_levels
    [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at difficult id level max_ex_score name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[ex_score_differences ex_scores favorite_songs]
  end
end
