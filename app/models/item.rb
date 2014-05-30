class Item < ActiveRecord::Base

  has_and_belongs_to_many :autos
  has_and_belongs_to_many :catalogs

  attr_accessible :name, :description, :catalog_ids, :auto_ids

  def self.search(search)
    unless search.blank?
      sss = search
      Item.where('LOWER(name) LIKE ?', "%#{sss}%") | where('LOWER(description) LIKE ?', "%#{sss}%") | joins(:autos).where('LOWER(autos.name) LIKE ?', "%#{sss}%")
      # find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end



end
