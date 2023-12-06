require './weather_machine'

document = File.read('day_01.txt')
weather_machine = WeatherMachine.new

puts weather_machine.sum_of_calibration_values(document)
