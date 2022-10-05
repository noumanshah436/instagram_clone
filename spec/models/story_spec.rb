require 'rails_helper'

RSpec.describe Story, type: :model do

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

  describe 'All stories' do
    it 'Should contain atleast one story' do 
      account = create :account
      account.stories.new(account_id: account.id, image: File.open("#{Rails.root}/app/assets/images/default2.png")  )
      all_stories = Story.all_stories
      expect(all_stories).not_to eq(nil)
    end
  end

end
