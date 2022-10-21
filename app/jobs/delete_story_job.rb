class DeleteStoryJob < ApplicationJob
  queue_as :default

  def perform(id, *_args)
    story = Story.find_by(id: id)
    return unless story

    puts "Story is Going to delete"
    story.destroy
    puts "Story Deleted successfully"
  end
end
