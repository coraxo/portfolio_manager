# Define class PortfolioItem
class PortfolioItem < ApplicationRecord
  belongs_to :portfolio
  has_rich_text :description

  validates :title, presence: true
  validates :url, presence: true
  validates :repository_url, presence: true
end
