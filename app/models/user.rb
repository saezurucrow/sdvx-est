# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  belongs_to :setting
  has_many :ex_scores
  has_many :upload_statuses

  enum arena_rank: {
    ULTEMATE: 0,
    S1: 1,
    S2: 2,
    S3: 3,
    S4: 4,
    A1: 5,
    A2: 6,
    A3: 7,
    A4: 8,
    B1: 9,
    B2: 10,
    B3: 11,
    B4: 12,
    C1: 13,
    C2: 14,
    C3: 15,
    C4: 16,
    D1: 17,
    D2: 18,
    D3: 19,
    D4: 20
  }

  validates :username, format: { with: /\A\w{4,}$\z/, message: 'は有効ではありません' }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
