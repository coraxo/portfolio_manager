class CreatePortfolioItems < ActiveRecord::Migration[8.1]
  def change
    create_table :portfolio_items do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :repository_url
      t.references :portfolio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
