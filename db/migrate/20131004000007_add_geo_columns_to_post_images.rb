class AddGeoColumnsToPostImages < ActiveRecord::Migration
  def change
  	add_column :post_images, :city, :string
  	add_column :post_images, :state, :string
  	add_column :post_images, :zipcode, :string
  end
end
