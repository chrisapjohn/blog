class AddStuffToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :lat, :decimal
  	add_column :posts, :lng, :decimal
  	add_column :posts, :city, :string
  	add_column :posts, :state, :string
  	add_column :posts, :zipcode, :string
  end
end
