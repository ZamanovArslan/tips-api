class CreateTips < ActiveRecord::Migration[6.0]
  def change
    create_table :tips do |t|
      t.string :title, null: false
      t.boolean :anonym, default: false
      t.text :description
      t.integer :experience
      t.text :experience_extended
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
