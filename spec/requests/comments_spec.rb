require 'rails_helper'

# RUBYOPT="-W0" rspec spec/requests/comments_spec.rb

RSpec.describe CommentsController, type: :controller do
  let(:post1) { create :post }
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
    end

    it 'should not create comment on post' do
      before_count = post1.comments.count
      post :create, params: { post_id: post1.id, comment: { account_id: account.id, post_id: post1.id, content: nil, parent_id: nil } }, xhr: true
      expect(post1.comments.count).to eq(before_count)
    end
  end

  describe 'Comment /update' do
    it 'should update comment on post' do
      sign_in(comment.account)
      before_count = post1.comments.count
      put :update, params: { id: comment.id, comment: { content: "updated comment" } }, xhr: true
      expect(post1.comments.count).to eq(before_count)
    end

    it 'should not update comment on post' do
      sign_in(comment.account)
      before_count = post1.comments.count
      put :update, params: { id: comment.id, comment: { content: nil } }, xhr: true
      expect(post1.comments.count).to eq(before_count)
    end
  end

  describe 'Comment /destroy' do
    it 'should delete comment on post' do
      comment = Comment.create({ account_id: account.id, post_id: post1.id, content: "new comment" })
      before_count = post1.comments.count
      delete :destroy, params: { id: comment.id }, xhr: true
      expect(post1.comments.count).to eq(before_count - 1)
    end

    it 'should not find comment' do
      delete :destroy, params: { id: 88888 }, xhr: true
      expect(flash[:alert]).to eq("comment not exist!")
      expect(response).to redirect_to root_path
    end
  end
end
