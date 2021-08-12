class CreatePatternWordTable < ActiveRecord::Migration[6.0]
  def change
    create_table :pattern_words do |t|
      t.references :word, foreign_key: true
      t.references :played_pattern, foreign_key: true
      t.boolean :is_correct, default: false
      t.timestamps
    end
    add_index :pattern_words, :is_correct
  end
end
