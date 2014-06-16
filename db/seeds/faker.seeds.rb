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

# Auto.all.each do |auto|
#   rand(1..5).times do
#     g = Generation.new
#     g.name = rand(1..10).to_s + 'th generation'
#     g.manhour = rand(300..1000)
#     if g.save
#       auto.generations << g
#     end
#   end
#   auto.save
# end

# Item.all.each do |item|
#   item.generations = []
#   rand(1..5).times do
#     x = rand(1..Generation.count)
#     if Generation.exists?(x)
#       item.generations << Generation.find(x)
#       item.generation_items.where(generation_id: x).first.dop_price = rand(500..5000)
#       item.save
#     end
#   end
# end

# GenerationItem.all.each do |gi|
#   gi.dop_price = rand(500..5000)
#   gi.save
# end

Item.all.each do |item|
  x = rand(1..Catalog.all.count)
  if Catalog.exists?(x)
    c = Catalog.find(x)
    unless c.blank? && c.root
      puts c.depth
    end
  end
  # item.save
end