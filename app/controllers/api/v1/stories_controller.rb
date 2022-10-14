module Api
  module V1
    class StoriesController < ApiController
      before_action :find_story, only: %i[show]

      # http://localhost:3000/api/v1/stories
      def index
        @stories = Story.includes(:account).all.map do |story|
           story_json = story.as_json
           story_json[:account] = story.account.as_json
           story_json
         end

        render json: @stories
      end

      # http://localhost:3000/api/v1/stories/20
      def show
        story_json = @story.as_json
        story_json[:account] = @story.account.as_json
        render json: story_json
      end

      def find_story
        @story = Story.find_by(id: params[:id])
        return if @story

        flash[:alert] = "Story not exist!"
        redirect_to root_path
      end




    end
  end
end
