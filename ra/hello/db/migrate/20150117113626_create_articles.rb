class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :location
      t.string :excerpt
      t.text :body
      t.datetime :publish_at

      t.timestamps
    end
  end
end
