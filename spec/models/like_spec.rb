require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Associations' do

    context 'with_belongs_to' do
      it { is_expected.to belong_to(:post) }
      it { is_expected.to belong_to(:account) }
    end

  end
end
