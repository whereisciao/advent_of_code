class WeatherMachine
  class Line
    WORD_TO_DIGIT = %w(one two three four five six seven eight nine).each.
      with_index(1).each_with_object({}) do |(word, index), memo|
        memo[word] = index.to_s
      end

    SUBPATTERN = WORD_TO_DIGIT.keys.unshift('\d').join('|')
    DIGITS_REGEX = Regexp.new("(?=(#{SUBPATTERN})(#{SUBPATTERN})?)")

    def initialize(line)
      @line = line
    end

    def calibration_value
      (values.first + values.last).to_i if values.size.positive?
    end

    def values
      @values ||= @line.
        scan(DIGITS_REGEX).
        each_with_object([]) do |matches, memo|
          matches.compact!
          if memo.empty?
            memo.concat(matches)
          elsif memo.last != matches.first
            memo << matches.first
          end
        end.map { |match| WORD_TO_DIGIT[match] || match }
    end
  end

  def calibration_values_from_document(document)
    document.split("\n").map do |line|
      Line.new(line).calibration_value
    end.compact
  end

  def sum_of_calibration_values(document)
    calibration_values_from_document(document).sum
  end
end