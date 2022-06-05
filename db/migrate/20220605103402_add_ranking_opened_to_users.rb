class AddRankingOpenedToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :opened, :score_opened
    add_column :users, :ranking_opened, :integer, default: 0, null: false
  end
end
