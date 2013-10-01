class Post < ActiveRecord::Base
  attr_accessible :body, :title

  belongs_to :user

  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "400x400>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
