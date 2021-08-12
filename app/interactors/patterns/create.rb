# frozen_string_literal: true

class Patterns::Create
  include Interactor
  delegate :params, :user_id, :pattern_id, :fail!, to: :context

  def call
    pattern = PlayedPattern.new(pattern_id: pattern_id, user_id: user_id)
    fail!(errors: pattern.errors) unless pattern.save
    upsert_words(params[:correct_words] + params[:wrong_words])
    create_pattern_words(pattern.id)
    context.pattern = pattern
  end

  def upsert_words(words)
    Word.import words.map { |word| { name: word } }, on_duplicate_key_ignore: true, validate: false
  end

  def create_pattern_words(pattern_id)
    pattern_words = pattern_word_attributes(params[:correct_words], true, pattern_id) + pattern_word_attributes(
      params[:wrong_words], false, pattern_id
    )
    PatternWord.import pattern_words, validate: false
  end

  def pattern_word_attributes(words, is_correct, played_pattern_id)
    result = Word.where(name: words)

    result.each_with_object([]) do |word, memo|
      memo << { word_id: word.id, is_correct: is_correct, played_pattern_id: played_pattern_id }
    end
  end
end
