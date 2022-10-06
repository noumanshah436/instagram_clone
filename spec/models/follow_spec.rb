require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'Associations' do
    context 'with_belongs_to' do
      it { should belong_to(:follower).class_name('Account') }
      it { should belong_to(:follower).class_name('Account') }
    end
  end
end
