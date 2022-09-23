class StoriesController < ApplicationController
  before_action :authenticate_account!

  def index
    if current_account.id.to_s == params[:account_id]
      @stories = Story.all.includes(:account)
    else
      flash[:alert] = "Invalid Access"
      redirect_to account_stories_path(current_account)
    end
  end



  def create
    if story_params.key?(:image)
      img = story_params[:image]
      @story= current_account.stories.new(story_params)
      if @story.save
        DeleteStoryJob.set(wait: 1.day).perform_later( @story.id)
        flash[:notice] = "Story Created"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:alert] = "Image Not Found ..."
    end
    redirect_to account_stories_path(current_account)
  end

  def destroy
    id =  story_destroy_params[:id]
    @story = Story.find_by(id: id)
    public_id = image_public_id( @story[:image] ) # destroy story image from cloudinary
    Cloudinary::Uploader.destroy(public_id)

    if @story.destroy
      flash[:notice] = "Story deleted!"
    else
      flash[:alert] = "Something went wrong ..."
    end
    redirect_to account_stories_path(current_account)
  end

  private

    def image_public_id ( str )
      myArray = str.split('/')
      filename =  myArray[myArray.length-1]
      index =(filename.length-5)
      return filename[0..index]
    end

    def story_destroy_params
      params.permit(:id)
    end


    def story_params
      params.require(:story).permit(:image, :image_cache ,:account_id)
    end
end
