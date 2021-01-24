class Character < ApplicationRecord
  has_many :information, dependent: :destroy
  accepts_nested_attributes_for :information,
                                 allow_destroy: true,
                                 reject_if: lambda{|attributes| attributes[:introduction].blank? || attributes[:height].blank? || attributes[:hobby].blank? || attributes[:favorite].blank?}
  has_many_attached :images

  validates :name_ja, :name_en, :name_gun, uniqueness: true, presence: true
  validate  :gun_category #古銃か現代銃かのみ選択

  private

  def gun_category
    x = self.gun_category_id
    unless x == 1 || x == 2
      errors.add(:gun_category_id, "Please select")
    end
  end

end
