class DeleteStoryJob < ApplicationJob
  queue_as :default

  def image_public_id ( str )
    myArray = str.split('/')
    filename =  myArray[myArray.length-1]
    index =(filename.length-5)
    return filename[0..index]
  end
  
  def perform( id , *args)
    puts "Job Scheduled"
    story = Story.find_by(id: id)
    if story
      public_id = image_public_id( story[:image] ) # destroy story image from cloudinary
      Cloudinary::Uploader.destroy(public_id)
      story.destroy
    end
  end
end
