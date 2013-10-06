class AddPostImageTable < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
