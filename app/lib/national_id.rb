# frozen_string_literal: true

class NationalId

  def initialize(attribute)
    @id = attribute
  end


  def info
    {
      birth_date: birth_date.strftime("%d of %B, %Y"),
      governorate: governorate_extractor,
      birth_date_sequance: sequance_extractor,
      gender: id[12].to_i % 2 == 0? 'Female' : 'Male'
    }
  end


  def valid?
    return false if id.length != 14
    return false if sequance_extractor.to_i <= 0

    birth_month_validator = '(0[1-9]|1[0-2])'
    national_id_regex = "(2|3)([0-9][1-9]|[1-9][0-9])#{birth_month_validator}#{day_validator}(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)[0-9][0-9][0-9][0-9][0-9]"
    return false unless id.match?(national_id_regex)

    min_age_exceeded?
  end

  private

  attr_reader :id

  def sequance_extractor
    id[9..12]
  end

  def month_extractor
    id[3..4]
  end

  def day_extractor
    id[5..6]
  end

  def year_extractor
    year = id[1..2]
    id[0].to_i == 2 ? "19#{year}" : "20#{year}"
  end

  def leap_year_validatior
    year_extractor.to_i % 4 == 0? '(0[1-9]|(1|2)[0,9])' : '(0[1-9]|(1|2)[0,8])'
  end

  def min_age_exceeded?
    TimeDifference.new(Time.now, birth_date).min_age_exceeded?
  end

  def birth_date
    Time.parse("#{year_extractor}-#{month_extractor}-#{day_extractor}")
  end

  def governorate_extractor
    governorate_number = id[7..8]
    Constants::GOVERNORATES[:"#{governorate_number}"]
  end

  def day_validator
    case month_extractor.to_i
    when 4 , 6 , 9 , 11
      '(0[1-9]|(1|2)[0,9]|30)'
    when 2
      leap_year_validatior()
    else
      '(0[1-9]|(1|2)[0,9]|3[0-1])'
    end
  end
end
