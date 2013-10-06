class Post < ActiveRecord::Base
  attr_accessible :body, :title, :image

  belongs_to :user

  has_one :image

  mount_uploader :image, ImageUploader

  before_save :extract_geolocation

	def extract_geolocation
		img = Magick::Image.read(self.image.current_path)[0] rescue nil

	    return unless img
	    img_lat = img.get_exif_by_entry('GPSLatitude')[0][1].split(', ') rescue nil
	    img_lng = img.get_exif_by_entry('GPSLongitude')[0][1].split(', ') rescue nil
	 
	    lat_ref = img.get_exif_by_entry('GPSLatitudeRef')[0][1] rescue nil
	    lng_ref = img.get_exif_by_entry('GPSLongitudeRef')[0][1] rescue nil
	 
	    return unless img_lat && img_lng && lat_ref && lng_ref
	 
	    latitude = to_frac(img_lat[0]) + (to_frac(img_lat[1])/60) + (to_frac(img_lat[2])/3600)
	    longitude = to_frac(img_lng[0]) + (to_frac(img_lng[1])/60) + (to_frac(img_lng[2])/3600)
	 
	    latitude = latitude * -1 if lat_ref == 'S'  # (N is +, S is -)
	    longitude = longitude * -1 if lng_ref == 'W'   # (W is -, E is +)
	 
	    self.lat = latitude
	    self.lng = longitude

    if geo = Geocoder.search("#{latitude},#{longitude}").first
      self.city = geo.city
      self.state = geo.state
      self.zipcode = geo.postal_code
    end
  end
 
  def to_frac(strng)
    numerator, denominator = strng.split('/').map(&:to_f)
    denominator ||= 1
    numerator/denominator
  end

	def categorize_post
		if self.body.length > 300
			self.is_blog = true
		else
			self.is_blog = false
		end
	end  
end
