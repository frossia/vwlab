class Page < ActiveRecord::Base

  attr_accessible :title, :intro, :full, :published, :alias

  validates_uniqueness_of :alias

end
