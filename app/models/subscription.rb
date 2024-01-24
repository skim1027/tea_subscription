class Subscription < ApplicationRecord
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas
  enum status: {"cancelled": 0, "active": 1}

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true
end
