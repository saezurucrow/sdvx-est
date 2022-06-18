# frozen_string_literal: true

class DeleteSongColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :songs, :artist, :string
    remove_column :songs, :version, :integer
  end
end
