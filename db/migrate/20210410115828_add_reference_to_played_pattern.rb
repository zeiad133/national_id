# frozen_string_literal: true

class AddReferenceToPlayedPattern < ActiveRecord::Migration[6.0]
  def change
    add_reference :played_patterns, :pattern, foreign_key: true
  end
end
