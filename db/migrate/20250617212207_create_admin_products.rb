class CreateAdminProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.bigint :brand_id
      t.bigint :category_id

      t.timestamps
    end
  end
end
