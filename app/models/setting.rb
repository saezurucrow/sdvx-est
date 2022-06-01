# frozen_string_literal: true

class Setting < ApplicationRecord
  has_one :user

  enum opened: {
    publiced: 0,
    privated: 1
  }
end
