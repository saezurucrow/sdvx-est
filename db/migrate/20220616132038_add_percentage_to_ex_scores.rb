# frozen_string_literal: true

class AddPercentageToExScores < ActiveRecord::Migration[6.1]
  def change
    add_column :ex_scores, :percentage, :float, default: 0, null: false
  end
end
