class Information < ApplicationRecord
  belongs_to :character

  before_validation :info_sprit #入力値前後のスペース除去
  #身長は140cm以上200cm以下
  validates :height, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 140,
                                     less_than_or_equal_to: 200 }
  validate  :info_count #銃一種につきinformationは2件まで

  private

  def info_count
    if character.information.count >= 2
      errors.add(:character, "銃一種につきinformationは2件です")
    end
  end

  def info_sprit
    self.introduction.strip!
    self.hobby.strip!
    self.favorite.strip!
  end

end
