# Define class PortfolioItem
class PortfolioItem < ApplicationRecord
  belongs_to :portfolio
  has_rich_text :description
  has_many_attached :images

  validates :title, presence: true
  validates :url, presence: true
  validates :repository_url, presence: true
  validates :images, content_type: ['image/png', 'image/jpg', 'image/jpeg'], limit: { max: 10 }, size: { less_than: 5.megabytes }
end
