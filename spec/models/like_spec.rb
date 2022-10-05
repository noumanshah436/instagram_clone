require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Associations' do

    context 'with_belongs_to' do
      it { is_expected.to belong_to(:post) }
      it { is_expected.to belong_to(:account) }
    end

    # context 'Uniqueness' do
    #   # it { should validate_uniqueness_of(:account_id).scoped_to(:post_id) }
      # it { is_expected.to validate_uniqueness_of(:account_id).scoped_to(:post_id) }


    # end

  end
end
