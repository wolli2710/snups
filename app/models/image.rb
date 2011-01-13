class Image < ActiveRecord::Base
  
  include MiniMagick

  before_destroy :delete_image_files
   
	has_many :comment, :dependent => :destroy
	has_many :rating, :dependent => :destroy
  has_many :report, :dependent => :destroy
	belongs_to :mission
	belongs_to :user
  
  attr_accessible :user_id, :mission_id, :nameHash
  
  validates :user_id, :presence => true, :numericality => true
  validates :mission_id, :presence => true, :numericality => true

  def delete_image_files
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_high.jpg")
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_medium.jpg")
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_low.jpg")
  end

  def self.handle_upload(image, params)

    image_name = Time.now.to_s+params[:username]
    image.nameHash = Digest::SHA1.hexdigest(image_name)

    input_path = params[:image].path()

    main_path = Rails.root.to_s + "/public/images/upload/"
    output_high = main_path + image.nameHash + "_high.jpg"
    output_medium = main_path + image.nameHash + "_medium.jpg"
    output_low = main_path + image.nameHash + "_low.jpg"

    uploaded_image = MiniMagick::Image.open(input_path)

    uploaded_image.write output_high

    uploaded_image = resize_and_crop_banner(uploaded_image, 300, 150)
    uploaded_image.write output_medium

    uploaded_image = resize_and_crop(uploaded_image, 100)
    uploaded_image.write output_low

    return image
  end
  
  def self.resize_and_crop(image, size)
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

  def self.resize_and_crop_banner(image, w, h)
    size = w.to_s + "x" + h.to_s

    image = resize_and_crop(image, w)

    shave_h = ((image[:height]- h)/2).round
    image.shave("0x#{shave_h}")

    return image
  end
end
