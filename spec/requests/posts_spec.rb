require 'rails_helper'

RSpec.describe PostsController, type: :controller  do
  let(:account) { create :account }
  let(:postt) { create :post }

  it 'GET index' do
    sign_in(account)
    get :index
    expect(response).to render_template :index
  end

  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end
end
