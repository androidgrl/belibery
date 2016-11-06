require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  def valid_attributes
    {
     city: "Pleasanton",
     state: "CA",
     country: "USA"
    }
  end

  test "it creates a location with valid attributes" do
    location = Location.new(valid_attributes)

    assert location.valid?
  end

  test "a location is invalid when the city is missing" do
    location = Location.new(state: "OH", country: "USA")

    refute location.valid?
  end

  test "a location is invalid when the state is missing" do
    location = Location.new(city: "Pleasanton", country: "USA")

    refute location.valid?
  end

  test "a location is invalid when the country is missing" do
    location = Location.new(city: "Pleasanton", state: "CA")

    refute location.valid?
  end

  test "a city must be unique within a scope of a state" do
    2.times { Location.create(valid_attributes) }
    Location.create(city: "Pleasanton", state: "TX", country: "USA")

    result = Location.where(city: "Pleasanton")
    assert_equal 2, result.count
  end

  test "a state must be exactly 2 characters" do
    location = Location.new(city: "Pleasanton", state: "California", country: "USA")

    refute location.valid?
  end

  test "cities and countries may only contain uppercase letters, lowercase letters and spaces" do
    location1 = Location.new(city: "P-town", state: "CA", country: "USA")
    location2 = Location.new(city: "Pleasanton", state: "Ca", country: "Country GB:9eY:FFF")
    location3 = Location.new(city: "PlEaSAnton ", state: "ca", country: "usa")

    refute location1.valid?
    refute location2.valid?
    assert location3.valid?
  end

  test "full_name returns a string of the city, state, and country" do
    location = Location.new(valid_attributes)

    assert_equal "Pleasanton, CA, USA", location.full_name
  end
end
