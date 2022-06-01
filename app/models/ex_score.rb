# frozen_string_literal: true

class ExScore < ApplicationRecord
  belongs_to :user
  belongs_to :song
end
