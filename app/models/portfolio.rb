class Portfolio < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_rich_text :description
end
