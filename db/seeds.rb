require 'faker'
require 'open-uri'

puts "🧹 Deleting users, all products, brands and categories..."
Product.destroy_all
Brand.destroy_all
Category.destroy_all
User.destroy_all
puts "✅ All products, brands and categories deleted."



puts "📦 Creating admin user..."
User.create!(
  email: "admin@gmail.com",
  password: "secret",
  password_confirmation: "secret",
  admin: true
)
puts "✅ Admin user created."


# ✅ Stałe i jednoznaczne nazwy marek
brand_names = ["Sony", "Adidas", "Ikea", "Penguin Books"]
brands = brand_names.map { |name| Brand.create!(name: name) }

# ✅ Stałe i jednoznaczne nazwy kategorii
category_names = ["Electronics", "Fashion", "Home", "Books"]
categories = category_names.map { |name| Category.create!(name: name) }

puts "📦 Created #{brands.count} brands and #{categories.count} categories."

puts "📦 Creating products with nice descriptions and images..."

15.times do
  category = categories.sample
  brand = brands.sample

  name = case category.name
         when "Electronics"
           "#{Faker::Device.manufacturer} #{Faker::Device.model_name}"
         when "Fashion"
           "#{Faker::Commerce.color.capitalize} #{Faker::Commerce.material} Shirt"
         when "Books"
           Faker::Book.title
         when "Home"
           "#{Faker::Appliance.brand} #{Faker::Appliance.equipment}"
         else
           Faker::Commerce.product_name
         end

  description = case category.name
                when "Books"
                  "A gripping #{Faker::Book.genre.downcase} novel by #{Faker::Book.author}."
                when "Electronics"
                  "High-quality #{Faker::Device.model_name.downcase} from #{Faker::Device.manufacturer}, designed for performance and reliability."
                when "Fashion"
                  "Stylish and comfortable, made from premium materials. Perfect for everyday wear."
                when "Home"
                  "Make your life easier with this top-rated kitchen essential from #{Faker::Appliance.brand}."
                else
                  Faker::Marketing.buzzwords
                end

  price = Faker::Commerce.price(range: 20..500)

  product = Product.create!(
    name: name,
    description: description,
    price: price,
    brand: brand,
    category: category
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

  puts "✅ Created: #{product.name} (Category: #{category.name}, Brand: #{brand.name})"
end

puts "🎉 Seed complete! Total products: #{Product.count}"