class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end
  has_many :sessions, dependent: :destroy
  has_one :portfolio

  validates :email_address, uniqueness: true
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :avatar, content_type: [ "image/png", "image/jpg", "image/jpeg" ], size: { less_than: 5.megabytes }
end
