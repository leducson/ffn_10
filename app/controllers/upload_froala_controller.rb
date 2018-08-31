class UploadFroalaController < ApplicationController
  def upload_image_froala
    ext = File.extname(params[:file].original_filename)
    name = "#{SecureRandom.hex(10)}-#{Time.now.to_i}#{ext}"
    derictory = "public/uploads/images"
    path = File.join(derictory, name)
    File.open(path, "wb"){|f| f.write(params[:file].read)}
    render json: {
      link: "/uploads/images/" + name
    }, layout: false, content_type: "text/html"
  end
end
