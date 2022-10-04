require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'Associations' do
    context 'with_have_many' do
      it { is_expected.to have_many(:photos).dependent(:destroy)}
      it { is_expected.to have_many(:likes).dependent(:destroy)}
      it { is_expected.to have_many(:comments).dependent(:destroy)}
    end

    context 'with_belongs_to' do
      it { is_expected.to belong_to(:account) }
    end

  end

  context 'validation tests' do
    it "should be active" do
      post = create(:post)
      expect(post).to be_active
    end

    it "should not be active" do
      post = create(:post)
      post.active = false
      post.save
      expect(post).not_to be_active
    end
  end

  context 'validation tests' do
    it "should belongs to given account" do
      post = create(:post)
      expect(post).to be_belongs_to(post.account)
    end
    it "should not belongs to given account" do
      post = create(:post)
      account = create(:account)
      expect(post).not_to be_belongs_to(account)
    end

  end

  context 'liked tests' do
    it "should be liked by given account" do
      post = create(:post)
      like = post.account.likes.create({post_id:post.id})
      like = post.liked(post.account)
      expect(like).not_to eq(nil)
    end

    it "should not be liked by given account" do
      post = create(:post)
      like = post.liked(post.account)
      expect(like).to eq(nil)
    end
  end

  context 'Post model' do
    it "should contain atleast one post" do
      post = create(:post)
      posts = Post.all_posts
      expect(posts).not_to eq(nil)
    end

    it "should contain atleast one parent comment" do
      post = create(:post)
      Comment.create({account_id:post.account.id, post_id:post.id, content: "new comment"})
      comments = post.parent_comments
      expect(comments).not_to eq(nil)
    end

    it "should not contain any parent comment" do
      post = create(:post)
      comments = post.parent_comments
      expect(comments).to eq([])
    end
  end







  # context 'validation tests' do
  #   it 'ensure title presence' do
  #     article = Article.new(title: "USfjfjfA").save
  #     expect(article).to eq(true)
  #   end
  # end
end
