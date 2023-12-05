require 'minitest/autorun'

class WeatherMachineTest < Minitest::Test
  def test_sum_of_calibration_values
    weather_machine = WeatherMachine.new
    assert_equal 142, weather_machine.sum_of_calibration_values(document)
  end

  def document
    document ||= <<~END_DOC
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    END_DOC
  end
end

class WeatherMachine
  def sum_of_calibration_values(document)
    document.split("\n").map do |line|
      values = line.scan(/-?\d+/)

      case(values.length)
      when 1
        value = values.first
        value + value
      else
        values.first + values.last
      end
    end.map(&:to_i).sum
  end
end