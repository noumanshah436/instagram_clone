require 'rails_helper'

# RUBYOPT="-W0" rspec spec/requests/posts_spec.rb

RSpec.describe PostsController, type: :controller  do
  let(:account) { create :account }
  let(:postt) { create :post }

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

  describe 'POST /create' do
    it 'should create post with valid attributes' do
      sign_in(account)
      before_count = Post.count
      post :create, params: { post: { content: "post content" },  images: { "0": File.open("#{Rails.root}/app/assets/images/default2.png")  } }
      expect(Post.count).to eq(before_count+1)
      expect(flash[:notice]).to eq("Post Created")
      expect(response).to redirect_to posts_path
    end

    it 'should not create post with invalid attributes' do
      sign_in(account)
      before_count = Post.count
      post :create, params: { post: { content: nil },  images: { "0": File.open("#{Rails.root}/app/assets/images/default2.png")  } }
      expect(Post.count).to eq(before_count)
      expect(flash[:alert]).to eq("Something went wrong ...")
    end

    it 'should not create post without image' do
      sign_in(account)
      before_count = Post.count
      post :create, params: { post: { content: "content" } }
      expect(Post.count).to eq(before_count)
      expect(flash[:alert]).to eq("Add atleast one image")
      expect(response).to redirect_to posts_path
    end
  end

  describe 'GET /show' do
    it 'should get show template' do
      sign_in(account)
      get :show, params: { id: postt.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET /edit' do
    it 'should get edit template' do
      sign_in(postt.account)
      get :edit, params: { id: postt.id }
      expect(response).to render_template :edit
    end
  end

 







end  #  end testing controller



# describe "GET /index" do
#   pending "add some examples (or delete) #{__FILE__}"
# end
