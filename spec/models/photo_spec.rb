require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'Associations' do
    context 'with_belongs_to' do
      it { is_expected.to belong_to(:post) }
    end
  end

  describe 'validation tests' do
    context 'presence of image' do
      it { is_expected.to validate_presence_of(:image) }
    end
  end

  describe "image" do
    context 'should valiadtes image' do
      it { is_expected.to validate_presence_of(:image) }
    end
  end
end
