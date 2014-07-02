class Auto < ActiveRecord::Base

  has_many :generations
  belongs_to :brand

  attr_accessible :name, :color, :car_image, :manhour, :brand_id, :item_ids

  default_scope { order('brand_id ASC') }
  scope :by_auto, -> auto { where(:brand_id => auto) }

  validates :name, :brand_id, :presence => true


  # scope :vw, where('brand.name = Volkswagen')
  # scope :vw, -> { joins(:brand).where(brand: { name: 'Film Maker' }) }

  # def all_vw
  #   Auto.find(:all, conditions: {:category_id => '1'})
  # end



end
