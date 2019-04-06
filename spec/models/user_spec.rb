require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { expect(:described_class.new).to be_valid }
  end
  context 'instance methods' do
    let(:user) { Fabricate(:user) }
    let(:right_password) { 'right_password' }
    let(:wrong_password) { 'wrong_password' }
    it { expect(user.authenticate(right_password)).to eq(user) }
    it { expect(user.authenticate(wrong_password)).to eq(false) }
  end
end
