class Image < ActiveRecord::Base
  
  include MiniMagick

  before_destroy :delete_image_files
   
	has_many :comment, :dependent => :destroy
	has_many :rating, :dependent => :destroy
  has_many :report, :dependent => :destroy
	belongs_to :mission
	belongs_to :user
  
  attr_accessible :user_id, :mission_id, :nameHash, :image_data
  
  validates :user_id, :presence => true, :numericality => true
  validates :mission_id, :presence => true, :numericality => true

  def image_data=(var)
    
    image_name = Time.now.to_s+rand(1000).to_s
    self.nameHash = Digest::SHA1.hexdigest(image_name)
    
    main_path = Rails.root.to_s + "/public/images/upload/"
    output_high = main_path + nameHash + "_high.jpg"
    output_medium = main_path + nameHash + "_medium.jpg"
    output_low = main_path + nameHash + "_low.jpg"

    uploaded_image = MiniMagick::Image.open(var.path)

    uploaded_image.write output_high

    uploaded_image = resize_and_crop_banner(uploaded_image, 300, 150)
    uploaded_image.write output_medium

    uploaded_image = resize_and_crop(uploaded_image, 100)
    uploaded_image.write output_low
    
  end
  
  def delete_image_files
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_high.jpg")
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_medium.jpg")
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_low.jpg")
  end

  def resize_and_crop(image, size)
    if image[:width] < image[:height]
      shave_off = ((
        image[:height]-
        image[:width])/2).round
        image.shave("0x#{shave_off}")
    elsif image[:width] > image[:height]
      shave_off = ((
        image[:width]-
        image[:height])/2).round
        image.shave("#{shave_off}x0")
    end
    image.resize size
    return image
  end

  def resize_and_crop_banner(image, w, h)
    size = w.to_s + "x" + h.to_s

    image = resize_and_crop(image, w)

    shave_h = ((image[:height]- h)/2).round
    image.shave("0x#{shave_h}")

    return image
  end

  def self.set_report_count(image)
    for report in Report.where(:image_id => image.id)
      report.destroy
    end
  end
end
