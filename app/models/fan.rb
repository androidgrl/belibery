class Fan < ActiveRecord::Base
  validates :name, presence: true,
    format: { with: /\A[a-zA-Z]+\z/, message: "only allows upper and lowercase letters" }
  validates :email, uniqueness: true, length: { in: 5..50 }, confirmation: true
  validates :email_confirmation, presence: true
  validate :no_richards
  has_many :donations
  belongs_to :location

  def no_richards
    errors.add(:name, "cannot be Richard") if name && name.downcase == "richard"
    #name is attribute of Fan
  end

  def nickname
    "#{name}lieber"
  end
end
