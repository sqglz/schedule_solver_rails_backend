require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe 'associations' do
    it { should have_many(:shift_assignments).dependent(:destroy)}
    it { should have_many(:assignments)}
  end
  describe 'Instance Methods' do
    describe '#filled?' do
      let(:filled_shift) { Fabricate(:shift_with_assignments) }
      let(:unfilled_shift) { Fabricate(:shift_with_assignments) }
      context 'shift with multiple shift_assignments' do
        it 'can go from *unsigned to *assigned when filled' do

        end
      end
    end
  end
end
