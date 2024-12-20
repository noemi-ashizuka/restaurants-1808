class Restaurant < ApplicationRecord
  # associations
  belongs_to :user
  has_many :reviews, dependent: :destroy # this will destroy the reviews of this restaurant
  # validations
  validates :name, presence: true
  # validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
