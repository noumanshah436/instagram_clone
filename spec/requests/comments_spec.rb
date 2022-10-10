require 'rails_helper'

# RUBYOPT="-W0" rspec spec/requests/comments_spec.rb

RSpec.describe CommentsController, type: :controller do
  include CommentsHelper

  let(:post1) { create(:post) }
  let(:account) { create :account }
  let(:comment) { create(:comment) }
  before do
    sign_in(account)
  end

  describe 'Comment /create' do
    it 'should create comment on post' do
      before_count = post1.comments.count
      post :create, params: { post_id: post1.id, comment: { account_id: account.id, post_id: post1.id, content: "new comment", parent_id: nil } },
                    xhr: true
      expect(post1.comments.count).to eq(before_count + 1)
      check_response
    end

    it 'should not create comment on post' do
      before_count = post1.comments.count
      post :create, params: { post_id: post1.id, comment: { account_id: account.id, post_id: post1.id, content: nil, parent_id: nil } }, xhr: true
      expect(post1.comments.count).to eq(before_count)
      expect(flash[:alert]).to eq("Something went wrong ...")
    end
  end

  describe 'Comment /update' do
    before do
      sign_in(comment.account)
    end

    it 'should update comment on post' do
      before_count = post1.comments.count
      put :update, params: { id: comment.id, comment: { content: "updated comment" } }, xhr: true
      expect(post1.comments.count).to eq(before_count)
      check_response
    end

    it 'should not update comment on post' do
      before_count = post1.comments.count
      put :update, params: { id: comment.id, comment: { content: nil } }, xhr: true
      expect(post1.comments.count).to eq(before_count)
      expect(flash[:alert]).to eq("Something went wrong ...")
    end
  end

  describe 'Comment /destroy' do
    let!(:comment) { Comment.create({ account_id: account.id, post_id: post1.id, content: "new comment" }) }

    it 'should delete comment on post' do
      before_count = post1.comments.count
      delete :destroy, params: { id: comment.id }, xhr: true
      expect(post1.comments.count).to eq(before_count - 1)
      check_response
    end

    it 'should not find comment' do
      delete :destroy, params: { id: 88_888 }, xhr: true
      expect(flash[:alert]).to eq("comment not exist!")
      expect(response).to redirect_to root_path
    end
  end
end
