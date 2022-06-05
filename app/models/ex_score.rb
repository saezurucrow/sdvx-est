# frozen_string_literal: true

require 'csv'

class ExScore < ApplicationRecord
  belongs_to :user
  belongs_to :song
  has_many :ex_score_difference

  EX_SCORE_CSV_HEADER = ['楽曲名', '難易度', '楽曲レベル', 'クリアランク', 'スコアグレード', 'ハイスコア', 'EXスコア', 'プレー回数', 'クリア回数', 'ULTIMATE CHAIN', 'PERFECT']

  def self.conversion_csv(text, user_id)
    File.open("tmp/ex_score_#{user_id}.csv", 'w') do |file|
      file.write(text)
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

      CSV.foreach(csv, headers: true, liberal_parsing: true) do |row|
        next if row['EXスコア'] == '0' || row.blank?

        song = Song.find_by(name: row['楽曲名'], level: row['楽曲レベル'])
        next if song.nil?

        ex_score = ExScore.find_by(user_id: user, song_id: song.id)
        max = (song.max_ex_score - row['EXスコア'].to_i) == 0

        if ex_score.nil?
          ex_score = ExScore.new(
            user_id: user.id,
            song_id: song.id,
            ex_score: row['EXスコア'],
            play_count: row['プレー回数'],
            max: max
          )
          ex_score.save!
          ExScoreDifference.create!(
            ex_score_id: ex_score.id,
            upload_status_id: upload_statuses.id,
            before_ex_score: 0,
            after_ex_score: row['EXスコア']
          )
          upload_score_count += 1
        elsif ex_score.ex_score == row['EXスコア']
          ex_score.update!(play_count: row['プレー回数'])
        else
          ex_score.update!(
            ex_score: row['EXスコア'],
            play_count: row['プレー回数'],
            max: max
          )
          ExScoreDifference.create!(
            ex_score_id: ex_score.id,
            upload_status_id: upload_statuses.id,
            before_ex_score: ex_score.ex_score,
            after_ex_score: row['EXスコア']
          )
          upload_score_count += 1
        end
      end

      raise '更新されたスコアが0件でした。EXスコアが全て0かSDVX-ESTの楽曲データ更新が遅れている可能性があります。' if upload_score_count == 0

      upload_statuses.update!(upload_score_count: upload_score_count)

      return upload_statuses
    end
  end

  def self.s_puc_count(user_id)
    ExScore.where(user_id: user_id, max: true).count
  end

  def self.s_puc_count_by_level(user_id)
    ExScore.joins(:song).where(user_id: user_id, max: true).group('songs.level').count
  end
end
