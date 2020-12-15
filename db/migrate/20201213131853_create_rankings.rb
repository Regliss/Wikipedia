class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.float :point, null:false, default: '0'
      t.references :user, null: false, foreign_key: true
 
      t.timestamps
    end
  end
end
