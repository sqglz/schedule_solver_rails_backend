require 'rails_helper'

RSpec.describe Responsibility, type: :model do
  context 'fabricators' do
    let(:responsibility) { Fabricate(:responsibility) }
    
    it { expect(responsibility).to be_valid }
  end
end
