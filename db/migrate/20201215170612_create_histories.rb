class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.string :content
      t.string :author
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
