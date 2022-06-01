# frozen_string_literal: true

class UploadStatus < ApplicationRecord
  has_many :ex_score_differences
  belongs_to :user
end
