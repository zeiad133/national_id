# frozen_string_literal: true

class AddUserFields < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :favorite_patterns_counts, :integer
    add_column :users, :high_score, :integer
    add_column :users, :puzzle_played, :integer
    add_column :users, :total_life_time_score, :integer
    add_column :users, :unique_pattern_played, :integer
    add_index :users, :name
  end
end
