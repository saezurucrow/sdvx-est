# frozen_string_literal: true

require 'csv'

class ExScore < ApplicationRecord
  belongs_to :user
  belongs_to :song
  has_many :ex_score_difference

  EX_SCORE_CSV_HEADER = ['楽曲名', '難易度', '楽曲レベル', 'クリアランク', 'スコアグレード', 'ハイスコア', 'EXスコア', 'プレー回数', 'クリア回数',
                         'ULTIMATE CHAIN', 'PERFECT'].freeze
  EX_SCORE_SONG_DIFFICULT = %w[NOVICE ADVANCED EXHAUST INFINITE GRAVITY MAXIMUM HEAVENLY VIVID EXCEED].freeze

  def self.conversion_csv(text, user_id)
    File.open("tmp/ex_score_#{user_id}.csv", 'w') do |file|
      file.write(text.strip)
    end
  end

  def self.confirm_score_csv?(csv)
    first_row = CSV.read(csv, liberal_parsing: true).first
    first_row == EX_SCORE_CSV_HEADER && CSV.read(csv, liberal_parsing: true).length > 1
  end

  def self.insert_ex_scores(csv, user)
    ActiveRecord::Base.transaction do
      upload_statuses = UploadStatus.new(user_id: user.id)
      upload_statuses.save!
      upload_score_count = 0
      max_count = 0

      CSV.foreach(csv, headers: true, liberal_parsing: true) do |row|
        next if row['EXスコア'] == '0' || row.blank?

        # TODO: データが収集できたら青、黄譜面も対応させる
        next if row['難易度'] == 'NOVICE' || row['難易度'] == 'ADVANCED'

        song = Song.find_by(name: row['楽曲名'], level: row['楽曲レベル'], difficult: EX_SCORE_SONG_DIFFICULT.index(row['難易度']))
        next if song.nil?

        if row['EXスコア'].to_i > song.max_ex_score && song.max_ex_score != -1
          raise "楽曲名: #{song.name} EXスコア値: #{row['EXスコア']} EXスコアのMAX値より高いスコアが検出されました。もしツールのEXスコア値に誤りがある場合はお手数ですが、スクリーンショットとともに運営Twiiter(X)にてお知らせください"
        end

        ex_score = ExScore.find_by(user_id: user, song_id: song.id)

        if ex_score.nil?
          max_minus = song.max_ex_score - row['EXスコア'].to_i
          max_count += 1 if max_minus === 0

          ex_score = ExScore.new(
            user_id: user.id,
            song_id: song.id,
            ex_score: row['EXスコア'].to_i,
            play_count: row['プレー回数'],
            max_minus: max_minus,
            percentage: (row['EXスコア'].to_i / song.max_ex_score.to_f).round(4)
          )
          ex_score.save!
          ExScoreDifference.create!(
            ex_score_id: ex_score.id,
            upload_status_id: upload_statuses.id,
            before_ex_score: 0,
            after_ex_score: row['EXスコア'].to_i
          )
          upload_score_count += 1
        elsif ex_score.ex_score == row['EXスコア'].to_i
          max_count += 1 if ex_score.max_minus === 0
          ex_score.update!(play_count: row['プレー回数'])
        else
          if (row['EXスコア'].to_i - ex_score.ex_score).negative?
            raise "楽曲名: #{song.name} 前回のEXスコア値: #{ex_score.ex_score} 今回のEXスコア値: #{row['EXスコア']} 前回のEXスコアよりも少ないEXスコアが検出されました。最新のスコアデータを登録してください。"
          end

          max_minus = song.max_ex_score - row['EXスコア'].to_i
          max_count += 1 if max_minus === 0

          ExScoreDifference.create!(
            ex_score_id: ex_score.id,
            upload_status_id: upload_statuses.id,
            before_ex_score: ex_score.ex_score,
            after_ex_score: row['EXスコア'].to_i
          )
          ex_score.update!(
            ex_score: row['EXスコア'].to_i,
            play_count: row['プレー回数'],
            max_minus: max_minus,
            percentage: (row['EXスコア'].to_i / song.max_ex_score.to_f).round(4)
          )
          upload_score_count += 1
        end
      end

      raise '更新されたスコアが0件でした。EXスコアが全て0かSDVX-ESTの楽曲データ更新が遅れている可能性があります。' if upload_score_count.zero?

      if max_count.positive?
        redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://redis:6379')
        redis.zadd('max_ranking', max_count, user.username)
      end

      upload_statuses.update!(upload_score_count: upload_score_count)

      return upload_statuses
    end
  end

  def self.s_puc_count(user_id)
    ExScore.joins(:song).where(user_id: user_id, max_minus: 0).where.not(song: { delete_flag: 1 }).count
  end

  def self.s_puc_count_by_level(user_id)
    ExScore.joins(:song).where(user_id: user_id, max_minus: 0).where.not(songs: { delete_flag: 1 }).group('songs.level').count
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at ex_score id max_minus percentage play_count song_id updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[ex_score_difference song user]
  end
end
