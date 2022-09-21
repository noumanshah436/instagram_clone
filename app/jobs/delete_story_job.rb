class DeleteStoryJob < ApplicationJob
  queue_as :default

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
