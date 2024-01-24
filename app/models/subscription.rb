class Subscription < ApplicationRecord
  has_many :teas
  belongs_to :customer
  enum status: {"cancelled": 0, "active": 1}

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true
end
