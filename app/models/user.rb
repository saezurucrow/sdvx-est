# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  has_many :ex_scores
  has_many :upload_statuses

  enum score_opened: {
    publiced: 0,
    privated: 1
  }

  enum ranking_opened: {
    publiced: 0,
    privated: 1
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
