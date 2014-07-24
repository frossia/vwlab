module ActiveAdmin::ViewsHelper
  include ApplicationHelper

  def grouped_options
    catalog = Catalog.all
    go = []
    catalog.each do |cat|
      if cat.depth == 0
        go << [cat.name, cat.descendants.map { |i| ["#{i.name}", i.id] }]
      end
    end
    go
  end
end