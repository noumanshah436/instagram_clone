module Api
  module V1
    class FollowersController < ApiController
      before_action :find_account, only: %i[show]


      # http://localhost:3000/api/v1/followers/1
      def show
        @followers = @account.followers
        render json: @followers
      end

      def find_account
        @account = Account.find_by(id: params[:id])
        return if @account

        flash[:alert] = "Account not exist!"
        redirect_to root_path
      end

    end
  end
end
