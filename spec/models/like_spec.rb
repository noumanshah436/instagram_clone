require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:post) { create :post }

  describe 'Associations' do
    context 'with_belongs_to' do
      it { is_expected.to belong_to(:post) }
      it { is_expected.to belong_to(:account) }
    end
  end

  context 'Uniqueness Validations' do
    subject { described_class.new(account_id: post.account.id, post_id: post.id) }
    it { is_expected.to validate_uniqueness_of(:account_id).scoped_to(:post_id) }
  end
end
