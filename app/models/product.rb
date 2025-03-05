class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  has_one_attached :image
  after_commit -> { broadcast_refresh_later_to "products" }
  validate :acceptable_image
  validates :title, uniqueness: true, length: { minimum: 10 }
  validates :description, :image, :title, presence: { message: "is a required field" }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  def acceptable_image
    return unless image.attached?

    puts image.content_type

    acceptable_types = [ "image/jpeg", "image/gif", "image/png" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPG, GIF or PNG image")
    end
  end

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "Line items present")
        throw :abort
      end
    end
end
