# frozen_string_literal: true

require 'csv'

if Rails.env != 'production' && (User.count === 0)
  # create User
  User.create!(
    username: 'chirping_crow',
    password: 'hogehoge'
  )
  user.save!
end

# create Song
if Song.count === 0
  DIFFICULT = %w[NOVICE ADVANCED EXHAUST INFINITE GRAVITY MAXIMUM HEAVENLY VIVID EXCEED]

  CSV.foreach('db/song_data/rev_effect_id.csv', headers: true) do |row|
    Song.create!(
      name: row[0],
      difficult: DIFFICULT.find_index(row[1]),
      level: row[2],
      max_ex_score: row[3] == -1 ? 0 : row[3]
    )
  end
end
