require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:error_messages) { guest.errors.full_messages }
    let(:guest) { Fabricate.build(:user, email: email) }

    before { guest.save }

    context 'when the email has multiple `@` characters' do
      let(:email) { 'awesome@weirdness.com@yo.com' }

      it { expect(guest).to_not be_valid }
      it { expect(error_messages).to include('Email format is invalid') }
    end

    context 'when the email has an incomplete TLD' do
      let(:email) { 'awesome@incompletetld' }

      it { expect(guest).to_not be_valid }
      it { expect(error_messages).to include('Email format is invalid') }
    end

    context 'when the email has multiple subdomains' do
      let(:email) { 'awesomeSauce123@verycompleteTLD.com.yo.com' }

      it { expect(guest).to be_valid }
      it { expect(error_messages).to be_empty }
    end

    context 'when the email has a `+` character' do
      let(:email) { 'awesome+Sauce123@gmail.com' }

      it { expect(guest).to be_valid }
      it { expect(error_messages).to be_empty }
    end

    context 'when the email is `nil`' do
      let(:email) { nil }

      it { expect(guest).to_not be_valid }
      it { expect(error_messages).to include("Email can't be blank") }
      it { expect(error_messages).to_not include('Email format is invalid') }
    end
  end

  describe 'instance methods' do
    describe '#authenticate' do
      let(:user) { Fabricate(:user) }
      let(:right_password) { 'right_Password123' }
      let(:wrong_password) { 'wrong_password' }
      it { expect(user.authenticate(right_password)).to eq(user) }
      it { expect(user.authenticate(wrong_password)).to eq(false) }
    end
  end
end
