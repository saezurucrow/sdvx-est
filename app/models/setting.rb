# frozen_string_literal: true

class Setting < ApplicationRecord
  enum opened: {
    public: 0,
    private: 1
  }
end
