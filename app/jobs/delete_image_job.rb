class DeleteImageJob < ApplicationJob
  queue_as :default

  def image_public_id ( str )
    myArray = str.split('/')
    filename =  myArray[myArray.length-1]
    index =(filename.length-5)
    return filename[0..index]
  end
  
  def perform(img , *args)
    puts "Job Scheduled"
    public_id = image_public_id( img ) # destroy story image from cloudinary
    Cloudinary::Uploader.destroy(public_id)
  end
end
