module Api
  module V1
    class StoriesController < ApiController
      def index
        @stories = Story.all_stories
        render json: @stories
      end
    end
  end
end
