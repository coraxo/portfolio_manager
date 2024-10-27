class Portfolio < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :portfolio_items, dependent: :destroy
  has_rich_text :description
end
