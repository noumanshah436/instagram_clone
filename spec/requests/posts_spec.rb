require 'rails_helper'

RSpec.describe PostsController, type: :controller  do
  let(:account) { create :account }
  let(:post) { create :post }

  describe 'when user enter any unknown id for show edit update' do
    it 'Post should not exist' do
      sign_in(account)
      get :show, params: { id: "1234567" }
      expect(flash[:alert]).to eq("Post not exist!")
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET /index' do
    it 'should get index template' do
      sign_in(account)
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET /show' do
    it 'should get show template' do
      sign_in(account)
      get :show, params: { id: post.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET /edit' do
    it 'should get edit template' do
      sign_in(post.account)
      get :edit, params: { id: post.id }
      expect(response).to render_template :edit
    end
  end




end  #  end testing controller



# describe "GET /index" do
#   pending "add some examples (or delete) #{__FILE__}"
# end
