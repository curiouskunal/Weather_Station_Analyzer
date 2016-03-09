require 'minitest/autorun'
require '../station.rb'
require '../weather.rb'

class StationTest < Minitest::Test
  def test_constructor
    station = Station.new 'GHCND:USR0000CTHO',
                          'THOMES CREEK CALIFORNIA CA US',
                          '150', '10', '-20'
    assert_equal 150, station.elevation
    assert_equal (Location.new 10, -20), station.location
    assert_equal 'GHCND:USR0000CTHO', station.code
    assert_equal 'THOMES CREEK CALIFORNIA CA US',
                 station.name
    assert_equal 0, station.connections

    station.inc_connections

    assert_equal 1, station.connections

    station.dec_connections

    assert_equal 0, station.connections

    weather = [
        Weather.new('20140101', '0', '0', '0'),
        Weather.new('20140101', '0', '0', '0'),
        Weather.new('20140101', '0', '0', '0')
    ]

    assert_equal [], station.weather
    for w in weather
      station.add_weather w
    end
    assert_equal weather, station.weather

  end
end

class LocationTest < Minitest::Test
  def setup
    @loc = Location.new 10, -20
  end

  def test_constructor
    assert_equal @loc.latitude, 10
    assert_equal @loc.longitude, -20
  end

  def test_equality
    assert_equal @loc, (Location.new 10, -20)
    refute_equal @loc, (Location.new 15, -20)
    refute_equal @loc, (Location.new 10, 15)
  end
end