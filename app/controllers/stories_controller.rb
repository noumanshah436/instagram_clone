class StoriesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_story, only: [:destroy]

  def index
    @stories = Story.all_stories
    @story = Story.new
  end

  def create
    @story = current_account.stories.new(story_params)
    if @story.save
      flash[:notice] = "Story Created"
      DeleteStoryJob.set(wait: 1.day).perform_later(@story.id)
    else
      flash[:alert] = "Something went wrong ..."
    end
    redirect_to stories_path
  end

  def destroy
    authorize @story
    if @story.destroy
      flash[:notice] = "Story deleted!"
    else
      flash[:alert] = "Something went wrong ..."
    end
    redirect_to stories_path
  end

  private

  def find_story
    @story = Story.find_by(story_destroy_params)
    return if @story

    flash[:alert] = "Story not exist!"
    redirect_to stories_path
  end

  def story_destroy_params
    params.permit(:id)
  end

  def story_params
    params.require(:story).permit(:image, :image_cache)
  end
end
