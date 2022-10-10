require 'rails_helper'

# RUBYOPT="-W0" rspec spec/models/story_spec.rb

RSpec.describe Story, type: :model do
  let(:account) { create(:account) }
  let(:story) { account.stories.new(account_id: account.id, image: File.open("#{Rails.root}/app/assets/images/default2.png")) }

  describe 'Associations' do
    context 'with_belongs_to' do
      it { is_expected.to belong_to(:account) }
    end
  end

  describe 'validation tests' do
    context 'presence of image' do
      it { is_expected.to validate_presence_of(:image) }
    end
  end

  describe '.all_stories' do
    it 'Should contain atleast one story' do
      all_stories = Story.all_stories
      expect(all_stories).not_to eq(nil)
    end
  end

  describe "image" do
    it "should have an image" do
      image = File.exist?(story.image.url)
      expect(image).not_to eq(nil)
    end
  end
end
