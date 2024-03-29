# frozen_string_literal: true

require 'csv'

redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://redis:6379')

if Rails.env != 'production' && (User.count === 0)
  # create User
  User.create!(
    username: 'chirping_crow',
    password: 'hogehoge',
    email: 'usobukuhito@gmail.com',
    is_admin: true
  )
  User.create!(
    username: 'regi',
    password: 'hogehoge',
    email: 'asdf@gmail.com'
  )
end

# create Song
if Song.count === 0
  DIFFICULT = %w[NOVICE ADVANCED EXHAUST INFINITE GRAVITY MAXIMUM HEAVENLY VIVID EXCEED].freeze

  CSV.foreach('db/song_data/rev_effect_id.csv', headers: true) do |row|
    # TODO: データが収集できたら青、黄譜面も対応させる
    next if row[1] == 'NOVICE' || row[1] == 'ADVANCED'

    Song.create!(
      name: row[0],
      difficult: DIFFICULT.find_index(row[1]),
      level: row[2],
      max_ex_score: row[3] == -1 ? 0 : row[3]
    )
  end
end

unless User.count === 0
  redis.flushall
  User.all.each do |user|
    max_count = user.ex_scores.s_puc_count(user.id)
    redis.zadd('max_ranking', max_count, user.username) if max_count.positive?
  end
end
