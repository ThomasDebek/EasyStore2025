require 'faker'
require 'open-uri'

puts "🧹 Deleting all products..."
Product.destroy_all
puts "✅ All products deleted."

# Kategorie do losowania
categories = ["Electronics", "Fashion", "Books", "Home & Kitchen", "Sports"]

puts "📦 Creating products with nice descriptions and images..."

15.times do
  category = categories.sample
  name = case category
         when "Electronics"
           "#{Faker::Device.manufacturer} #{Faker::Device.model_name}"
         when "Fashion"
           "#{Faker::Commerce.color.capitalize} #{Faker::Commerce.material} Shirt"
         when "Books"
           Faker::Book.title
         when "Home & Kitchen"
           "#{Faker::Appliance.brand} #{Faker::Appliance.equipment}"
         when "Sports"
           "#{Faker::Sports::Football.team} Training Gear"
         end

  description = case category
                when "Books"
                  "A gripping #{Faker::Book.genre.downcase} novel by #{Faker::Book.author}."
                when "Electronics"
                  "High-quality #{Faker::Device.model_name.downcase} from #{Faker::Device.manufacturer}, designed for performance and reliability."
                when "Fashion"
                  "Stylish and comfortable, made from premium materials. Perfect for everyday wear."
                when "Home & Kitchen"
                  "Make your life easier with this top-rated kitchen essential from #{Faker::Appliance.brand}."
                when "Sports"
                  "Durable and lightweight, ideal for both training and competition."
                else
                  Faker::Marketing.buzzwords
                end

  price = Faker::Commerce.price(range: 20..500)

  product = Product.create!(
    name: name,
    description: description,
    price: price
  )

  image_url = "https://picsum.photos/seed/#{rand(1000)}/600/400"

  begin
    downloaded_image = URI.open(image_url)
  rescue OpenURI::HTTPError => e
    puts "⚠️ Could not download image for #{name}: #{e.message}"
    next
  end

  product.image.attach(
    io: downloaded_image,
    filename: "#{name.parameterize}.jpg",
    content_type: 'image/jpeg'
  )

  puts "✅ Created: #{product.name} (#{category})"
end

puts "🎉 Seed complete! Total products: #{Product.count}"