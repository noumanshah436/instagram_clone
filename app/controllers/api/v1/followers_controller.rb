module Api
  module V1
    class FollowersController < ApiController
      before_action :find_account, only: %i[show]

      def show
        if @account.nil?
          render json: { status: 'ERROR', message: 'Account not found' }, status: :not_found
        else
          @followers = @account.followers
          render json: { status: 'SUCCESS', message: 'Loaded Followers', data: @followers }, status: :ok
        end
      end

      def find_account
        @account = Account.find_by(id: params[:id])
      end
    end
  end
end

# http://localhost:3000/api/v1/followers/1
