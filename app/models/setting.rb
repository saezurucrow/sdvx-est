# frozen_string_literal: true

class Setting < ApplicationRecord
  has_one :user

  enum opened: {
    public: 0,
    private: 1
  }
end
