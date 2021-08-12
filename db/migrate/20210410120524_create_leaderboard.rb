# frozen_string_literal: true

class CreateLeaderboard < ActiveRecord::Migration[6.0]
  def change
    create_table :leaderboards do |t|
      t.timestamps
      t.references :pattern, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :score, null: false
    end
  end
end
