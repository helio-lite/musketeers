class Information < ApplicationRecord
  belongs_to :character

  validates :height, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 140,
                                     less_than_or_equal_to: 200 }
end
