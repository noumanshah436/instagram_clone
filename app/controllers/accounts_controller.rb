class AccountsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_account , only: [:follow, :unfollow, :show ]

  def follow
    id = account_params[:id]
    Follow.create(follower_id: current_account.id, followee_id: id)
    respond_to do |format|
      format.js
    end
  end

  def unfollow
    id = account_params[:id]
    current_account.followed_users.where(follower_id: current_account.id, followee_id: id).destroy_all
    respond_to do |format|
      format.js
    end
  end

  def show
    # every one can see our profile

    # if we want to restrict , we can do with pundit like
    # authorize @account   # we can access this passed object using record
  end

  def index
    if params.key?(:id)
      keyword = params[:keyword]
      @users = Account.search(keyword.strip)
      respond_to do |format|
        format.js
      end
    end
    redirect_to account_path(current_account)
  end

  private

    #  now pundit user will get current_account object
    def pundit_user
      current_account
    end

    def set_account
      @account = Account.find_by( id: params[:id])
      return if @account

      flash[:alert] = "Account not exist!"
      redirect_to account_path(current_account)
    end

    def account_params
      params.permit(:id)
    end


end
