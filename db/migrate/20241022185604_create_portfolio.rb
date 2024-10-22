class CreatePortfolio < ActiveRecord::Migration[8.0]
  def change
    create_table :portfolios do |t|
      t.string :title
      t.text :introduction
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
  end
end