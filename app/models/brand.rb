class Brand < ActiveRecord::Base

  has_many :autos

  attr_accessible :name, :image, :image_32, :color

  validates :name, :image, :image_32, :presence => true

end
