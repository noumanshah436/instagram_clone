class DeleteStoryJob < ApplicationJob
  queue_as :default

  def perform(id, *_args)
    story = Story.find_by(id: id)
    return unless story

    flash[:alert] = if story.destroy
                      "story deleted ..."
                    else
                      "Something went wrong ..."
                    end
  end
end
