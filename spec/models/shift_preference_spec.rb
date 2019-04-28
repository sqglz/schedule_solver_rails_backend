require 'rails_helper'

RSpec.describe ShiftPreference, type: :model do
  context 'validations' do
    it { expect(subject).to validate_presence_of(:shift) }
    it { expect(subject).to validate_presence_of(:user) }
  end
  context 'preferences' do
    let(:preferred_shift) { Fabricate(:shift_preference, answer: 0) }
    let(:unpreferred_shift) { Fabricate(:shift_preference, answer: 1) }
    let(:unavailable_shift) { Fabricate(:shift_preference, answer: 2) }

    it { expect(preferred_shift).to be_valid }
    it { expect(unpreferred_shift).to be_valid }
    it { expect(unavailable_shift).to be_valid }

    it { expect(preferred_shift.answer).to eq('preferred') }
    it { expect(unpreferred_shift.answer).to eq('available') }
    it { expect(unavailable_shift.answer).to eq('unavailable') }
  end
end
