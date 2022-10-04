require 'rails_helper'

RSpec.describe Account, type: :model do

  describe 'Associations' do
    context 'with_have_many' do
      it { is_expected.to have_many(:posts).dependent(:destroy)}
      it { is_expected.to have_many(:likes).dependent(:destroy)}
      it { is_expected.to have_many(:comments).dependent(:destroy)}
      it { is_expected.to have_many(:stories).dependent(:destroy)}

      it { should have_many(:followees).through(:followed_users) }
      it { should have_many(:followers).through(:following_users) }

    end

    context 'presence of name' do
      it { is_expected.to validate_presence_of(:name) }
    end


  end

  describe 'Search' do
    it "should find" do
      account = create(:account, name:"Nouman")
      result = Account.search('Nouman').first
      expect(result).to eq(account)

    end
  end

  context 'Given Account' do
    it "should be active" do
      account = create(:account)
      expect(account).to be_active
    end

    it "should not be active" do
      account = create(:account)
      account.active = false
      account.save
      expect(account).not_to be_active
    end
  end

  context "my_posts" do
    it "should have posts when friend" do
      account = create(:account)
      account.posts.create(content: "new Post")

      my_posts = account.my_posts(true)
      expect(my_posts).not_to eq(nil)
    end

    it "should have posts when not friend" do
      account = create(:account)
      account.posts.create(content: "new Post")

      my_posts = account.my_posts(false)
      expect(my_posts).not_to eq(nil)
    end
  end

  context "followers" do
    it "should follow  givin account  " do
      account1 = create(:account)
      account2 = create(:account)
      account1.follow(account2)
      expect(account2.followers.first).to eq(account1)

      account1.unfollow(account2)
      expect(account2.followers).to eq([])
    end

    it "should unfollow  givin account  " do
      account1 = create(:account)
      account2 = create(:account)
      account1.follow(account2)
      account1.unfollow(account2)
      expect(account2.followers).to eq([])
    end
  end

  it "All follow Requests" do
    account1 = create(:account)
    account2 = create(:account)
    account1.follow(account2)
    all_follow_requests = account2.all_follow_requests
    expect(all_follow_requests.first).to eq(account1)
  end

  context "Friend" do
    it "is friend" do
    account1 = create(:account)
    account2 = create(:account)
    account1.follow(account2)
    account2.follow(account1)
    expect(account1.friend?(account2)).to eq(true)
  end

  end












end
