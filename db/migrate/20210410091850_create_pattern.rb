# frozen_string_literal: true

class CreatePattern < ActiveRecord::Migration[6.0]
  def change
    create_table :played_patterns do |t|
      t.string :code
      t.timestamps
      t.references :user, foreign_key: true
    end
    add_index :played_patterns, :code
  end
end
