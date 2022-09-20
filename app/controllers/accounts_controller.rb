class AccountsController < ApplicationController

  def show
    @account = Account.find(params[:id])
  end

  def index
    @users = Account.search(params[:keyword])
    respond_to do |format|
      format.js
    end
  end

end
