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
  def Character.search_result(keyword, category, gun_type, country)
    if keyword.present?
      if category.blank? && gun_type.blank? && country.blank?
        Character.
          where("name_ja like ? OR name_en like ? OR name_gun like ? OR motif like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
      elsif category.present? || gun_type.present? || country.present?
        Character.
          where("(name_ja like ? OR name_en like ? OR name_gun like ? OR motif like ?) AND (gun_category_id = ? OR gun_type_id = ? OR country_id = ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", category, gun_type, country)
      else
        Character.
          where("(name_ja like ? OR name_en like ? OR name_gun like ? OR motif like ?) AND (gun_category_id = ? AND gun_type_id = ? AND country_id = ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", category, gun_type, country)
      end
    else
      if category.present? && gun_type.present? && country.present?
        Character.
          where("gun_category_id = ? AND gun_type_id = ? AND country_id = ?", category, gun_type, country)
      elsif category.present? || gun_type.present? || country.present?
        Character.
          where("gun_category_id = ? OR gun_type_id = ? OR country_id = ?", category, gun_type, country)
      else
        Character.all
      end
    end
  end
end
