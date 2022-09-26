class StoriesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_story, only: [:destroy]

  def index
    @stories = Story.all.includes(:account).order("id desc")
    @story = Story.new
  end

  def create
    if story_params.key?(:image)
      @story = current_account.stories.new(story_params)
      if @story.save
        DeleteStoryJob.set(wait: 1.day).perform_later(@story.id)
        flash[:notice] = "Story Created"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:alert] = "Image Not Found ..."
    end
    redirect_to stories_path
  end

  def destroy
    if @story.account == current_account
      public_id = image_public_id(@story[:image]) # destroy story image from cloudinary
      Cloudinary::Uploader.destroy(public_id)
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

  def image_public_id(str)
    my_array = str.split('/')
    filename = my_array[my_array.length - 1]
    index = (filename.length - 5)
    filename[0..index]
  end

  def find_story
    id = story_destroy_params[:id]
    @story = Story.find_by(id: id)

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
