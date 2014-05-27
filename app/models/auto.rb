class Auto < ActiveRecord::Base

  has_and_belongs_to_many :items
  belongs_to :brand

  attr_accessible :name, :color, :car_image, :brand_id, :item_ids

  scope :by_auto, -> auto { where(:brand_id => auto) }

  # scope :vw, where('brand.name = Volkswagen')
  # scope :vw, -> { joins(:brand).where(brand: { name: 'Film Maker' }) }

  # def all_vw
  #   Auto.find(:all, conditions: {:category_id => '1'})
  # end



end
