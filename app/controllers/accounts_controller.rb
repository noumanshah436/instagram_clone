class AccountsController < ApplicationController

  def show
    @account = Account.find(params[:id])
  end

  def index
    keyword = params[:keyword]
    @users = Account.search(keyword.strip)
    respond_to do |format|
      format.js
    end
  end

end
