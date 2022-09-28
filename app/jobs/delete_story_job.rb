class DeleteStoryJob < ApplicationJob
  queue_as :default



  def perform(id, *_args)
    puts "Job Scheduled"
    story = Story.find_by(id: id)

    return unless story
    if story.destroy
      flash[:alert] = "story deleted ..."
    else
      flash[:alert] = "Something went wrong ..."
    end
  end
end
