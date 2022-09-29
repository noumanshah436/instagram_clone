class ErrorsController < ApplicationController
  def not_found
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def internal_server_error
    render file: 'public/500.html', status: :not_found, layout: false
  end
end
