require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    context 'with_have_many' do
      it { is_expected.to have_many(:comments).with_foreign_key('parent_id').dependent(:delete_all) }
    end

    context 'with_belongs_to' do
      it { is_expected.to belong_to(:post) }
      it { is_expected.to belong_to(:account) }
      it { is_expected.to belong_to(:parent).class_name('Comment').optional }
    end

    context 'presence of content' do
      it { is_expected.to validate_presence_of(:content) }
    end

    context 'Length Validation' do
      it { is_expected.to validate_length_of(:content).is_at_most(500) }
    end
  end
end
