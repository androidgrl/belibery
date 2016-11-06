require 'test_helper'

class FanTest < ActiveSupport::TestCase

  def valid_attributes
    {
      name: "Dmitry",
      email: "dmitry@beliber.com",
      email_confirmation: "dmitry@beliber.com"
    }
  end

  test "creates a fan with valid attributes" do
    fan = Fan.new(valid_attributes)

    assert fan.valid?
  end

  test "fan is invalid without a name" do
    fan = Fan.new(email: "jamie@beliber.com")

    refute fan.valid?
  end

  test "fan is invalid without an email" do
    fan = Fan.new(name: "Jamie")

    refute fan.valid?
  end

  test "it cannot create a fan with a duplicate email" do
    2.times { Fan.create(valid_attributes) }

    result = Fan.where(email: "dmitry@beliber.com")
    assert_equal 1, result.count
  end

  test "the name can only contain uppercase and lowercase letters" do
    fan = Fan.new(name: "J7mie", email: "jamie@belieber.com")

    refute fan.valid?
  end

  test "email must be between 5 and 50 characters" do
    fan = Fan.new(name: "Jamie", email: "j")

    refute fan.valid?
  end

  test "fan cannot be named Richard" do
    fan = Fan.new(name: "Richard", email: "richard@belieber.com")

    refute fan.valid?
  end

  test "fan has a belieber nickname" do
    fan = Fan.new(valid_attributes)

    assert_equal "Dmitrylieber", fan.nickname
  end

  test "a fan belongs to a location" do
    fan = Fan.new(valid_attributes)

    assert fan.respond_to?(:location), "Undefined method"
  end

  test "a fan is invalid if the email is not confirmed" do
    fan = Fan.new(name: "Jamie", email: "jamie@gmail.com", email_confirmation: "jamiekaw@comcast.net")

    refute fan.valid?
  end

  test "a fan has donations" do

  end
end
