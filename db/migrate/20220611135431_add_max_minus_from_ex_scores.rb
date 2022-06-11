class AddMaxMinusFromExScores < ActiveRecord::Migration[6.1]
  def change
    add_column :ex_scores, :max_minus, :integer, default: -1, null: false
  end
end
