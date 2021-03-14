class Character < ApplicationRecord
  has_many :information, dependent: :destroy
  accepts_nested_attributes_for :information,
                                 # 削除フラグで削除できるようにする
                                 allow_destroy: true,
                                 # いずれかが未入力なら登録しない
                                 reject_if: lambda{|attributes| attributes[:introduction].blank? || attributes[:height].blank? || attributes[:hobby].blank? || attributes[:favorite].blank?}

  # Active Storage
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

  # 条件ごとに検索をscope設定
  # キーワード検索/ActiveRecord::Relation 維持
  scope :keyword, ->(keyword) do
    where(<<-SQL, keyword: "%#{keyword}%")
      name_ja LIKE :keyword
      OR name_en LIKE :keyword
      OR name_gun LIKE :keyword
      OR motif LIKE :keyword
      SQL
  end

  scope :gun_category, -> (category){ where(gun_category_id: category) if category.present? }
  scope :gun_type, -> (gun_type){ where(gun_type_id: gun_type) if gun_type.present? }
  scope :country, -> (country){ where(country_id: country) if country.present? }
end
