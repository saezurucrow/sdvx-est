# frozen_string_literal: true

class AddOpenedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :opened, :integer, default: 0, null: false
  end
end
