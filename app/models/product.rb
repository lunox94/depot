class Product < ApplicationRecord
  has_one_attached :image
  after_commit -> { broadcast_refresh_later_to "products" }
  validate :acceptable_image
  validates :title, uniqueness: true
  validates :description, :image, :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  def acceptable_image
    return unless image.attached?

    puts image.content_type

    acceptable_types = [ "image/jpeg", "image/gif", "image/png" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPG, GIF or PNG image")
    end
  end
end
