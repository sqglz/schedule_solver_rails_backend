require 'rails_helper'

RSpec.describe 'Schedule', type: :class  do
  describe 'general behavior' do
    let!(:owner)    { Fabricate(:user_with_business) }
    let!(:schedule) { Fabricate(:schedule, owner_id: owner.id) }
    it { expect(schedule).to be_valid }
    it { expect(schedule).to have_many(:shifts) }
    it { expect(schedule).to belong_to(:owner) }
    it { expect(schedule).to belong_to(:business) }
    context 'validations' do
      it { expect(subject).to validate_presence_of(:business_id) }
      it { expect(subject).to validate_presence_of(:owner_id) }
    end
  end
end
