module Api
  module V1
    class ProfileController < ApiController

      # http://localhost:3000/api/v1/profile
      def index
        @accounts = Account.all
        render json: @accounts
      end


    end
  end
end
