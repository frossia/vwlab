require 'nokogiri'
require 'open-uri'

# dir = '/Users/Admin/projects/mossab/tmp/papers'


items = []
item = Hash.new
i = 0
doc = Nokogiri::HTML(open('http://www.ulmart.ru/catalog/car_audio_video?sort=5&viewType=1&rec=true'), nil, 'UTF-8')

doc.css('.b-product-list-item__title a').each_with_index do |title, i|
  title = title.content.squish
  desc  = doc.css('.b-product-list-item__descr')[i].content.squish
  price = doc.css('.b-product-list-item__current-price span.num')[i].content.squish

  items << {:title => title, :desc => desc, :price => price}

  new_item = Item.new
  new_item.name = title
  new_item.description = desc
  new_item.price = price

  rand(1..5).times do
    id = rand(1..Generation.count)
    if Generation.exists?(id)
      new_item.generations << Generation.find(id)
      new_item.save
      new_item.generation_items.where(generation_id: id).first.dop_price = rand(500..5000)
    end
  end

  x = rand(1..Catalog.all.count)
  if Catalog.exists?(x)
    unless Catalog.find(x).depth == 0
      new_item.catalog = Catalog.find(x)
    end
  end

  new_item.install_hours = rand(3..25)

  new_item.save

  # p title.content.squish
end

# doc.css('.b-product-list-item__descr').each_with_index do |desc, i|
#   item = Hash.new
#   item[:desc] = desc.content.squish
#   items[i][:desc] = item[:desc]
# end

puts items


