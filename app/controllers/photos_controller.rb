class PhotosController < ApplicationController

  before_action :find_photo, only: %i[destroy]

  def destroy
    if @image.delete
      flash[:notice] = "Image deleted!"
    else
      flash[:notice] = "something went wrong!"
    end
    respond_to do |format|
      format.js
    end
  end

  def image_public_id(str)
    my_array = str.split('/')
    filename = my_array[my_array.length - 1]
    index = (filename.length - 5)
    filename[0..index]
  end

  private

  def find_photo
    @image = Photo.find_by(id: params[:id])
    return if @image
    
    flash[:alert] = "Image not exist!"

  end
end
