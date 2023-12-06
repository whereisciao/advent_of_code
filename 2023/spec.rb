require './weather_machine'
require 'minitest/autorun'

class WeatherMachineTest < Minitest::Test
  def test_sum_of_calibration_values
    document = <<~END_DOC
      1abc2
      pqr3stu8vwx
      lisa
      a1b2c3d4e5f
      treb7uchet
    END_DOC
    weather_machine = WeatherMachine.new
    assert_equal [12, 38, 15, 77], weather_machine.calibration_values_from_document(document)
    assert_equal 142, weather_machine.sum_of_calibration_values(document)
  end

  def test_sum_of_calibration_values_two
    document = <<~END_DOC
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    END_DOC
    weather_machine = WeatherMachine.new
    assert_equal [29, 83, 13, 24, 42, 14, 76], weather_machine.calibration_values_from_document(document)
    assert_equal 281, weather_machine.sum_of_calibration_values(document)
  end

  def test_simple_line
    line = WeatherMachine::Line.new("1abc2")
    assert_equal 12, line.calibration_value
  end

  def test_complex_line
    line = WeatherMachine::Line.new("jjgjbqgbnz4gdsqk66991")
    assert_equal 41, line.calibration_value
  end

  def test_line_spelled_out
    line = WeatherMachine::Line.new("two1nine")
    assert_equal 29, line.calibration_value
  end

  def test_line_spelled_out_with_gibberish
    line = WeatherMachine::Line.new("7pqrstsixteen")
    assert_equal 76, line.calibration_value
  end

  def test_line_reversal
    line = WeatherMachine::Line.new("9eightszgdhftggrktkzbsmnhtwonekh")
    assert_equal 91, line.calibration_value
  end
end

