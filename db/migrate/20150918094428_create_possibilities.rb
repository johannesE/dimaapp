class CreatePossibilities < ActiveRecord::Migration
  def change
    create_table :possibilities do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
