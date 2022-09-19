class PhotosController < ApplicationController

  def destroy
    puts "photo deleted"
    @image = Photo.find_by( id: params[:id])
    # puts "@image"
    # p @image
    # puts "image.image"
    # p @image[:image]

    public_id = image_public_id( @image[:image] )
    Cloudinary::Uploader.destroy(public_id)   # delete from cloudinary
    @image.delete

    flash[:notice] = "Image deleted!"
    respond_to do |format|
      format.js
    end
    
    # redirect_back(fallback_location: fallback_location)

  end

  def image_public_id ( str )
    myArray = str.split('/')
    filename =  myArray[myArray.length-1]
    index =(filename.length-5)
    return filename[0..index]
  end


end


#  Cloudinary::Uploader.destroy('hvkwsmtbz3pg5bhk4w8h')

#<Photo id: 24, image: "image/upload/v1663590930/hvkwsmtbz3pg5bhk4w8h.png", post_id: 52, created_at: "2022-09-19 12:35:27", updated_at: "2022-09-19 12:35:27">

#  https://support.cloudinary.com/hc/en-us/community/posts/200788242-Problem-Deleting-Image-From-Rails-Heroku-App
