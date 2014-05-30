# 10.times do
#
# p = Faker::Commerce.product_name
# puts p
# end

  # manhour = rand(200..400)
# Item.all.each do |item|
#   item.install_hours = rand(1..30)
#   item.save
#   puts item.install_hours
#   puts '--------------------------------------------------'
# end
#
# Auto.all.each do |item|
#   item.manhour = rand(200..500)
#   item.save
#   puts item.manhour
#   puts '--------------------------------------------------'
# end

# Catalog.all.each do |cat|
#   puts '====================='+cat.name+'======================='
#   rand(0..6).times do
#     item = Item.find(rand(1..Item.count))
#     cat.items << item
#     puts '<< ' + item.name
#     cat.save
#   end
# end


# 44.times do
#   item = Item.new
#   item.name = Faker::Commerce.product_name
#   item.description = Faker::Lorem.paragraph(rand(2..10))
#   item.price = rand(3000..53333)
#   item.install_hours = rand(1..45)
#   item.save
# end

# Item.all.each do |item|
#   x = rand(1..Catalog.count)
#   if Catalog.exists?(x)
#     if Catalog.find(x).depth != 0
#       item.catalogs = []
#       item.catalogs << Catalog.find(x)
#       item.save
#     end
#   end
# end

item = Item.where(:install_hours => Item.maximum(:install_hours))
# item = Item.max(:install_hours)

puts item.pluck(:name, :install_hours)

# Item.each do |item|
#
# end