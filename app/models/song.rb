# frozen_string_literal: true

class Song < ApplicationRecord
  enum difficult: {
    NOV: 0,
    ADV: 1,
    EXH: 2,
    INF: 3,
    GRV: 4,
    MXM: 5,
    HVN: 6,
    VVD: 7,
    XCD: 8
  }
end
