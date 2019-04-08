require 'rails_helper'

RSpec.describe BusinessUser, type: :model do
  context 'Validations' do
    it { expect(subject).to validate_presence_of(:business) }
    it { expect(subject).to validate_presence_of(:user) }
  end
end
