class Location < ActiveRecord::Base
  validates :city, presence: true, uniqueness: { scope: :state, message: "already exists for that state" }, format: { with: /\A[a-zA-Z ]+\z/, message: "can only contain letters or spaces"}
  validates :state, presence: true, length: { is: 2 }
  validates :country, presence: true, format: { with: /\A[a-zA-Z ]+\z/, message: "can only contain letters or spaces"}

  has_many :fans

  def full_name
    "#{city}, #{state}, #{country}"
  end
end
