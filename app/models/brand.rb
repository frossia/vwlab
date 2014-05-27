class Brand < ActiveRecord::Base

  has_many :autos

  attr_accessible :name, :image

end
