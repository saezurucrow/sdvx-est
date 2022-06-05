# frozen_string_literal: true

class ExScoreDifference < ApplicationRecord
  belongs_to :ex_score
  belongs_to :upload_status
end
