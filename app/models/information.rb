class Information < ApplicationRecord
  belongs_to :character

  #身長は140cm以上200cm以下
  validates :height, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 140,
                                     less_than_or_equal_to: 200 }
  before_validation :info_sprit #入力値前後のスペース除去

  def info_sprit
    self.introduction.strip!
    self.hobby.strip!
    self.favorite.strip!
  end
end
