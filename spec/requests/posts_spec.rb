require 'rails_helper'

# RUBYOPT="-W0" rspec spec/requests/posts_spec.rb

RSpec.describe PostsController, type: :controller do
  let(:account) { create :account }
  let(:postt) { create :post }

  before do
    sign_in(account)
    sign_in(postt.account)
  end

  describe 'when user enter any unknown id for show edit update' do
    it 'Post should not exist' do
      get :show, params: { id: "1234567" }
      expect(flash[:alert]).to eq("Post not exist!")
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET /index' do
    it 'should get index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST /create' do
    it 'should create post with valid attributes' do
      before_count = Post.count
      post :create, params: { post: { content: "post content" }, images: { "0": File.open("#{Rails.root}/app/assets/images/default2.png") } }
      expect(Post.count).to eq(before_count + 1)
      expect(flash[:notice]).to eq("Post Created")
      expect(response).to redirect_to posts_path
    end

    it 'should not create post with invalid attributes' do
      before_count = Post.count
      post :create, params: { post: { content: nil }, images: { "0": File.open("#{Rails.root}/app/assets/images/default2.png") } }
      expect(Post.count).to eq(before_count)
      expect(flash[:alert]).to eq("Something went wrong ...")
      expect(response).to redirect_to posts_path
    end

    it 'should not create post without image' do
      before_count = Post.count
      post :create, params: { post: { content: "content" } }
      expect(Post.count).to eq(before_count)
      expect(flash[:alert]).to eq("Add atleast one image")
      expect(response).to redirect_to posts_path
    end
  end

  describe 'GET /show' do
    it 'should get show template' do
      get :show, params: { id: postt.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET /edit' do
    it 'should get edit template' do
      get :edit, params: { id: postt.id }
      expect(response).to render_template :edit
    end
  end

  describe 'PUT /update' do
    it 'should update post' do
      put :update, params: { id: postt.id, post: { content: "post Updated" } }
      postt.reload
      expect(flash[:notice]).to eq("Post Updated")
      expect(response).to redirect_to post_path(postt)
    end

    it 'should not update post' do
      put :update, params: { id: postt.id, post: { content: nil } }
      postt.reload
      expect(flash[:alert]).to eq("Something went wrong ...")
      expect(response).to redirect_to post_path(postt)
    end
  end

  describe 'delete /destroy' do
    it 'should delete post' do
      before_count = Post.count
      delete :destroy, params: { id: postt.id }
      expect(Post.count).to eq(before_count - 1)
      expect(flash[:notice]).to eq("Post deleted!")
      expect(response).to redirect_to posts_path
    end
  end
end
