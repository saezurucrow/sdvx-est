# frozen_string_literal: true

class ExScoreDifference < ApplicationRecord
  belongs_to :song
  belongs_to :upload_status
end
