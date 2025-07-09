### Develop ### 


 
Added your secret key 🔐

config/configuration.yml
weather_api_key: 'Your code from https://www.weatherapi.com/signup.aspx'
google_client_id: 'Your kode from https://console.cloud.google.com/apis/dashboard?inv=1&invt=Ab1Ofw&project=discountstore'
google_client_secret: 'Your kode from  https://console.cloud.google.com/apis/dashboard?inv=1&invt=Ab1Ofw&project=discountstore'
app_host: 'http://localhost:3000'



Search: 
If you run:  rake db:drop db:create db:migrate db:seed
When You must run this migration your hand. 


and 
you must run:
bin/rails db:migrate:down VERSION=20250625125218
bin/rails db:migrate:up VERSION=20250625125218

and bin/dev


Part 12 / Cart
🎯 GOAL: Add a shopping cart to the application
We will implement:
📦 Models: Cart, CartItem
🔗 Associations with User and Admin::Product
🔁 Service: AddProductToCart (no business logic in the controller)
🧩 Controller: CartsController
🧪 Tests: Request specs + System tests
🖼️ Views: products/show, carts/show
🛤️ Routing
💎 Migrations
🧪 (optional): RemoveFromCart test