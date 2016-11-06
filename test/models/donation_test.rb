require 'test_helper'

class DonationTest < ActiveSupport::TestCase

  test "a valid donation is created" do
    donation = Donation.new(amount: 2, fan_id: 2, status: "processed")

    assert donation.valid?
  end

  test "donation can only be a whole number" do
    donation = Donation.new(amount: 1.2, fan_id: 2, status: "pending")

    refute donation.valid?
  end

  test "donation must have a status" do
    donation = Donation.new(amount: 2, fan_id: 2)

    refute donation.valid?
  end

  test "donation status can only be processed, pending, or cancelled" do
    donation = Donation.new(amount: 2, fan_id: 1, status: "maybe")

    refute donation.valid?
  end

  test "donation cannot be 1" do
    donation = Donation.new(amount: 1, fan_id: 1, status: "pending")

    refute donation.valid?
  end

  test "donation belongs to a fan" do
    donation = Donation.new(amount: 2, fan_id: 1, status: "pending")

    assert donation.respond_to?(:fan)
  end
end
