# frozen_string_literal: true

class UpdateUserColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :deleted, :boolean, null: false, default: false
    add_column :users, :deleted_at, :integer
    add_column :users, :admin, :boolean, null: false, default: false

    rename_column :users, :skillLevel, :skill_level
    rename_column :users, :arenaRank, :arena_rank
    rename_column :users, :arenaScore, :arena_score
    rename_column :users, :palyerId, :player_id
    rename_column :users, :playerName, :player_name
  end
end
