require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe 'associations' do
    it { should have_many(:shift_responsibilities).dependent(:destroy)}
    it { should have_many(:responsibilities)}
  end
  describe 'Instance Methods' do
    describe '#filled?' do
      let(:filled_shift) { Fabricate(:shift_with_responsibilities) }
      let(:unfilled_shift) { Fabricate(:shift_with_responsibilities) }
      context 'shift with multiple shift_responsibilities' do
        it 'can go from *unsigned to *assigned when filled' do
          
        end
      end
    end
  end
end
