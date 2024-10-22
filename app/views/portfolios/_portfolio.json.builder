json.extract! portfolio, :id, :title, :introduction, :description, :created_at, :updated_at
json.url portfolio_url(portfolio, format: :json)
