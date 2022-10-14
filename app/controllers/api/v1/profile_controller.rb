module Api
  module V1
    class ProfileController < ApiController
      def index
        @accounts = Account.all
        render json: @accounts
      end
    end
  end
end

# http://localhost:3000/api/v1/profile
