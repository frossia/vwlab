class ItemAttachment < ActiveRecord::Base

  mount_uploader :image, ImageUploader
  belongs_to :item

  attr_accessible :item_id, :image, :remove_image

end
