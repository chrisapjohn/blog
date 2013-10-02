class AddIsBlogToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :is_blog, :boolean
  end
end
