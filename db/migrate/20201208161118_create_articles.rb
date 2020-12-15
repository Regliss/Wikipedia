class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
