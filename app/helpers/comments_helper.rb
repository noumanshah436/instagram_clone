module CommentsHelper
  def check_response
    expect(response).to have_http_status(:ok)
  end
end
