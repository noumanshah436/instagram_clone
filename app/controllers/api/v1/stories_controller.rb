module Api
  module V1
    class StoriesController < ApiController
      before_action :find_story, only: %i[show]

      def index
        @stories = Story.includes(:account).all.map do |story|
          story_json = story.as_json
          story_json[:account] = story.account.as_json
          story_json
        end
        render json: { status: 'SUCCESS', message: 'Loaded Stories', data: @stories }, status: :ok
      end

      def show
        if @story.nil?
          render json: { status: 'ERROR', message: 'Story not found' }, status: :not_found
        else
          story_json = @story.as_json
          story_json[:account] = @story.account.as_json
          render json: { status: 'SUCCESS', message: 'Loaded Story', data: story_json }, status: :ok
        end
      end

      def find_story
        @story = Story.find_by(id: params[:id])
      end
    end
  end
end

# http://localhost:3000/api/v1/stories
# http://localhost:3000/api/v1/stories/20
