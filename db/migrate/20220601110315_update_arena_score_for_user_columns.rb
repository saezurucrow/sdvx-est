# frozen_string_literal: true

class UpdateArenaScoreForUserColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :arena_score, :ultimate_score
  end
end
