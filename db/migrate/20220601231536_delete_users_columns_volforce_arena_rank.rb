class DeleteUsersColumnsVolforceArenaRank < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :volforce, :float
    remove_column :users, :arena_rank, :integer
    remove_column :users, :ultimate_score, :integer
  end
end
