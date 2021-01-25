class Information < ApplicationRecord
  belongs_to :character

  #身長は140cm以上200cm以下
  validates :height, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 140,
                                     less_than_or_equal_to: 200 }
end
