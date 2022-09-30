class DeleteImageJob < ApplicationJob
  queue_as :default

  def image_public_id(str)
    my_array = str.split('/')
    filename = my_array[my_array.length - 1]
    index = (filename.length - 5)
    filename[0..index]
  end

  def perform(img, *_args)
    public_id = image_public_id(img) # destroy story image from cloudinary
    Cloudinary::Uploader.destroy(public_id)
  end
end
