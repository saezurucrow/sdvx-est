# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  has_many :ex_scores
  has_many :upload_statuses
  has_many :favorite_songs, dependent: :destroy

  enum score_opened: {
    publiced: 0,
    privated: 1
  }

  enum ranking_opened: {
    open: 0,
    close: 1
  }

  validates :username, presence: true, format: { with: /\A\w{4,}$\z/, message: 'は有効ではありません' }, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at deleted deleted_at email encrypted_password id is_admin player_id player_name ranking_opened
       remember_created_at reset_password_sent_at reset_password_token score_opened updated_at username]
  end
end
