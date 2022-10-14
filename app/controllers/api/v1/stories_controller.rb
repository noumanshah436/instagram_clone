module Api
  module V1
    class StoriesController < ApiController
      before_action :find_story, only: %i[show]

      def index
        @stories = Story.all
        render json: @stories
      end

      def show
        if @story.nil?
          render json: @story,  status: :not_found
          # render json: { data: nil, status: 'ERROR', message: 'Story not found' },  status: :not_found
        else
          render json: @story , status: :ok
          # render json:{ data: @story, status: 'SUCCESS', message: 'Story Loaded' } , status: :ok
        end
      end

      def find_story
        @story = Story.find_by(id: params[:id])
      end
    end
  end
end

# http://localhost:3000/api/v1/followers/1
# http://localhost:3000/api/v1/stories/20