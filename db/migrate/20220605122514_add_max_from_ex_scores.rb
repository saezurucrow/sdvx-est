class AddMaxFromExScores < ActiveRecord::Migration[6.1]
  def change
    add_column :ex_scores, :max, :boolean, default: false, null: false
  end
end
