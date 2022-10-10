require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account1) { create :account }
  let(:account2) { create :account }

  describe 'Associations' do
    context 'with_have_many' do
      it { is_expected.to have_many(:posts).dependent(:destroy) }
      it { is_expected.to have_many(:likes).dependent(:destroy) }
      it { is_expected.to have_many(:comments).dependent(:destroy) }
      it { is_expected.to have_many(:stories).dependent(:destroy) }

      it { should have_many(:followees).through(:followed_users) }
      it { should have_many(:followers).through(:following_users) }
    end

    context 'presence of name' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  describe 'default scope' do
    let!(:account1) { create :account }
    let!(:account2) { create :account }

    it 'orders by descending id' do
      expect(Account.all).to eq([account2, account1])
    end
  end

  describe '.search' do
    let!(:account) { create(:account, name: "Nouman") }

    it "should find user account if present" do
      result = Account.search('Nouman').first
      expect(result).to eq(account)
    end
  end

  describe '#active' do
    it "should be active" do
      expect(account1).to be_active
    end

    it "should not be active" do
      account2.active = false
      account2.save
      expect(account2).not_to be_active
    end
  end

  describe "#my_posts" do
    it "should have posts when friend" do
      account1.posts.create(content: "new Post")
      my_posts = account1.my_posts(true)
      expect(my_posts).not_to eq(nil)
    end

    it "should have posts when not friend" do
      account1.posts.create(content: "new Post")
      my_posts = account1.my_posts(false)
      expect(my_posts).not_to eq(nil)
    end
  end

  describe "#follow" do
    it "should follow  givin account  " do
      account1.follow(account2)
      expect(account2.followers.first).to eq(account1)
    end

    it "should unfollow  givin account  " do
      account1.follow(account2)
      account1.unfollow(account2)
      expect(account2.followers).to eq([])
    end
  end

  it "#all_follow_requests" do
    account1.follow(account2)
    all_follow_requests = account2.all_follow_requests
    expect(all_follow_requests.first).to eq(account1)
  end

  describe "#friend?" do
    it "account1 should be friend of account2" do
      account1.follow(account2)
      account2.follow(account1)
      expect(account1.friend?(account2)).to eq(true)
    end
  end

  describe "image" do
    it "should have an image" do
      image = account1.image.url
      expect(image).not_to eq(nil)
    end
  end
end
