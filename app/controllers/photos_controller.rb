class PhotosController < ApplicationController

  

  def destroy
    @image = Photo.find_by(id: params[:id])
    public_id = image_public_id(@image[:image])
    Cloudinary::Uploader.destroy(public_id)   # delete from cloudinary
    @image.delete

    flash[:notice] = "Image deleted!"
    respond_to do |format|
      format.js
    end
    puts "photo deleted"
  end

  def image_public_id(str)
    my_array = str.split('/')
    filename = my_array[my_array.length - 1]
    index = (filename.length - 5)
    filename[0..index]
  end
end
