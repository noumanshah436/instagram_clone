require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create :post }
  let(:account) { create :account }

  describe 'Associations' do
    context 'with_have_many' do
      it { is_expected.to have_many(:photos).dependent(:destroy) }
      it { is_expected.to have_many(:likes).dependent(:destroy) }
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end

    context 'with_belongs_to' do
      it { is_expected.to belong_to(:account) }
    end
  end

  describe '#active' do
    context "should be active" do
      it { expect(post).to be_active }
    end

    context "should be active" do
      it do
        post.active = false
        post.save
        expect(post).not_to be_active
      end
    end
  end

  describe '#be_belongs_to' do
    context "should belongs to given account" do
      it { expect(post).to be_belongs_to(post.account) }
    end

    context "should not belongs to given account" do
      it { expect(post).not_to be_belongs_to(account) }
    end
  end

  describe '#liked' do
    context "should be liked by given account" do
      it do
        post.account.likes.create({ post_id: post.id })
        like = post.liked(post.account)
        expect(like).not_to eq(nil)
      end
    end

    context "should not be liked by given account" do
      it do
        like = post.liked(account)
        expect(like).to eq(nil)
      end
    end
  end

  describe '.all_posts' do
    it "should contain atleast one post" do
      posts = Post.all_posts
      expect(posts).not_to eq(nil)
    end
  end

  describe '#parent_comments' do
    it "should contain atleast one parent comment" do
      Comment.create({ account_id: account.id, post_id: post.id, content: "new comment" })
      comments = post.parent_comments
      expect(comments).not_to eq(nil)
    end

    it "should not contain parent comment" do
      post2 = create(:post)
      comments = post2.parent_comments
      expect(comments).to eq([])
    end
  end
end
