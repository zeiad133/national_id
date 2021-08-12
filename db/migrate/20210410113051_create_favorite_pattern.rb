# frozen_string_literal: true

class CreateFavoritePattern < ActiveRecord::Migration[6.0]
  def change
    create_table :patterns do |t|
      t.timestamps
      t.string :code, null: false
    end
    add_index :patterns, :code, unique: true

    create_table :user_patterns do |t|
      t.timestamps
      t.references :pattern, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
