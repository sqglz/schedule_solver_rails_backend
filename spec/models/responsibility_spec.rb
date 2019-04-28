require 'rails_helper'

RSpec.describe Assignment, type: :model do
  context 'fabricators' do
    let(:assignment) { Fabricate(:assignment) }

    it { expect(assignment).to be_valid }
  end
end
