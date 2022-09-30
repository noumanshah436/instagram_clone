class PhotosController < ApplicationController
  before_action :find_photo, only: %i[destroy]

  def destroy
    flash[:notice] = if @image.delete
                       "Image deleted!"
                     else
                       "something went wrong!"
                     end
    respond_to do |format|
      format.js
    end
  end

  private

  def find_photo
    @image = Photo.find_by(id: params[:id])
    return if @image

    flash[:alert] = "Image not exist!"
  end
end
