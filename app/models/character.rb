class Character < ApplicationRecord
  has_many :information, dependent: :destroy
  accepts_nested_attributes_for :information,
                                 allow_destroy: true,
                                 reject_if: lambda{|attributes| attributes[:introduction].blank? || attributes[:height].blank? || attributes[:hobby].blank? || attributes[:favorite].blank?}
  has_many_attached :images

  validates :name_ja, :name_en, :name_gun, presence: true #同名でも別銃の場合があるので同名可
  validate  :gun_category #古銃か現代銃かのみ選択
  before_validation :character_sprit #入力値前後スペース除去

  private

  def gun_category
    x = self.gun_category_id
    unless x == 1 || x == 2
      errors.add(:gun_category_id, "Please select")
    end
  end

  def character_sprit
    self.name_ja.strip!
    self.name_en.strip!
    self.name_gun.strip!
    self.motif.strip!
  end
end
