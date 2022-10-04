require 'rails_helper'

RSpec.describe Follow, type: :model do

  describe 'Associations' do
    context 'with_belongs_to' do
      it { is_expected.to belong_to(:follower) }
      it { is_expected.to belong_to(:followee) }
    end
  end

end
