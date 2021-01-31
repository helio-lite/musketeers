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

  # 条件ごとに検索を分岐する
  def Character.search_result(keyword, category, country)
    if keyword.present?
      if country.blank? && category.blank?
        Character.
          where("name_ja like ? OR name_en like ? OR name_gun like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
      elsif country.present? || category.present?
        Character.
          where("(name_ja like ? OR name_en like ? OR name_gun like ?) AND (gun_category_id = ? OR country_id = ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", category, country)
      else
        Character.
          where("(name_ja like ? OR name_en like ? OR name_gun like ?) AND (gun_category_id = ? AND country_id = ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", category, country)
      end
    else
      if country.present? && category.present?
        Character.
          where("gun_category_id = ? AND country_id = ?", category, country)
      elsif country.present? || category.present?
        Character.
          where("gun_category_id = ? OR country_id = ?", category, country)
      else
        Character.all
      end
    end
  end
end
