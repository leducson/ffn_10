class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [40, 40]
  end

  version :medium do
    process resize_to_fill: [150, 150]
  end

  version :large do
    process resize_to_fill: [900, 500]
  end
end
