class Portfolio < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
