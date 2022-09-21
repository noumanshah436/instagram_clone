class StoriesController < ApplicationController
  before_action :authenticate_account!

  def index
    @stories = Story.all.includes(  :account).order("id desc")
    @story = Story.new
  end



  def create
    if story_params.key?(:image)
      img = story_params[:image]
      @story= current_account.stories.new(story_params)
      if @story.save
        flash[:notice] = "Story Created"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:alert] = "Image Not Found ..."
    end

    redirect_to account_stories_path

  end


  def show
  end

  def destroy
  end

  private
    # Use callbacks to share common methods between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:image, :image_cache ,:account_id)
    end
end

# <ActionController::Parameters
# {"utf8"=>"✓",
# "authenticity_token"=>"yrCzTGUYviuDV9qFC9dpzUE2vpCu5IOYmGIUv+WjYep1aeeLm3Lqv6c/3dR7u29RR0PfJhjIuUNRjE6Sybpg0g==",
# "story"=>{ "image"=>#<ActionDispatch::Http::UploadedFile:0x00007f06ac158290 @tempfile=#<Tempfile:/tmp/RackMultipart20220921-104456-izk6w0.jpg>, @original_filename="2022-09-19-230459.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"story[image]\"; filename=\"2022-09-19-230459.jpg\"\r\nContent-Type: image/jpeg\r\n">, "image_cache"=>""}, "commit"=>"Add Story",
# "controller"=>"stories", "action"=>"create", "account_id"=>"4"} permitted: false>


# Parameters: {"utf8"=>"✓", "authenticity_token"=>"+AUyf0S7PnU+QG4Cr0z1k1uKu8b1xs7QQlDuLARPpMRH3Ga4utFq4RooaVPfIPMPXf/acEPq9AuLvrQBKFal/A==",
# "story"=>{"image"=>#<ActionDispatch::Http::UploadedFile:0x00007ff0844b6938 @tempfile=#<Tempfile:/tmp/RackMultipart20220921-187639-hbz8a4.png>, @original_filename="Screenshot from 2022-09-08 16-37-17.png", @content_type="image/png", @headers="Content-Disposition: form-data; name=\"story[image]\"; filename=\"Screenshot from 2022-09-08 16-37-17.png\"\r\nContent-Type: image/png\r\n">, "image_cache"=>""},
# "commit"=>"Add Story", "account_id"=>"4"}
