class ErrorsController < ApplicationController
  def not_found
    # render status: 404
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end

  def internal_server_error
    # render status: 500
    render :file => 'public/500.html', :status => :not_found, :layout => false
  end
end
