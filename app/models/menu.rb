class Menu < ActiveRecord::Base

  acts_as_list

  attr_accessible :title, :url, :published, :position

  default_scope -> {order('position ASC')}

end
