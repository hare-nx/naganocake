class Item < ApplicationRecord
  has_one_attached :image_id
  belongs_to :genre
  has_many :order_details
  has_many :cart_items

  def with_tax_price
    (price * 1.1).floor
  end

  def get_image_id
    unless image_id.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      image_id.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image_id
  end
end
