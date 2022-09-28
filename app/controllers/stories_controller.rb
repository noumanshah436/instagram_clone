class StoriesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_story, only: [:destroy]

  def index
    @stories = Story.all.includes(:account).order("id desc")
    @story = Story.new
  end

  def create
    @story = current_account.stories.new(story_params)
    if @story.save
      DeleteStoryJob.set(wait: 1.day).perform_later(@story.id)
      flash[:notice] = "Story Created"
    else
      flash[:alert] = "Something went wrong ..."
    end
    redirect_to stories_path
  end

  def destroy
    if @story.account == current_account
      if @story.destroy
        flash[:notice] = "Story deleted!"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:alert] = "You don't have permission to do that!"
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
