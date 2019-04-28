require 'rails_helper'

RSpec.describe Business, type: :model do
  describe 'validations' do
    it { expect(subject).to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    context 'user associations' do
      let(:business) { Fabricate(:business_with_employees) }

      it { expect(business.employees.count).to eq(3) }
    end
  end
end
