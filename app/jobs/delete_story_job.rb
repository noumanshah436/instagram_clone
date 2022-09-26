class DeleteStoryJob < ApplicationJob
  queue_as :default

  def image_public_id(str)
    my_array = str.split('/')
    filename = my_array[my_array.length - 1]
    index = (filename.length - 5)
    filename[0..index]
  end

  def perform(id, *_args)
    puts "Job Scheduled"
    story = Story.find_by(id: id)

    return unless story

    public_id = image_public_id(story[:image]) # destroy story image from cloudinary
    Cloudinary::Uploader.destroy(public_id)
    story.destroy
  end
end
