require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'email validations' do
      let(:error_messages) { user.errors.full_messages }
      let(:user) { Fabricate.build(:user, email: email) }

      before { user.save }

      context 'when the email has multiple `@` characters' do
        let(:email) { 'awesome@weirdness.com@yo.com' }

        it { expect(user).to_not be_valid }
        it { expect(error_messages).to include('Email format is invalid') }
      end

      context 'when the email has an incomplete TLD' do
        let(:email) { 'awesome@incompletetld' }

        it { expect(user).to_not be_valid }
        it { expect(error_messages).to include('Email format is invalid') }
      end

      context 'when the email has multiple subdomains' do
        let(:email) { 'awesomeSauce123@verycompleteTLD.com.yo.com' }

        it { expect(user).to be_valid }
        it { expect(error_messages).to be_empty }
      end

      context 'when the email has a `+` character' do
        let(:email) { 'awesome+Sauce123@gmail.com' }

        it { expect(user).to be_valid }
        it { expect(error_messages).to be_empty }
      end

      context 'when the email is `nil`' do
        let(:email) { nil }

        it { expect(user).to_not be_valid }
        it { expect(error_messages).to include("Email can't be blank") }
        it { expect(error_messages).to_not include('Email format is invalid') }
      end
    end

    context 'password validations' do
      let(:error_messages) { user.errors.full_messages }
      let(:user) do
        Fabricate.build(
          :user,
          password: password,
          password_confirmation: password
        )
      end

      before { user.save }

      context 'when password is under 10 characters' do
        let(:password) { 'abc123D'}

        it { expect(user).to_not be_valid }
      end
      context 'when password is over 10 characters' do
        let(:password) { 'abc123D_zyd'}

        it { expect(user).to be_valid }
      end
    end

    context 'username' do
      let(:user) { Fabricate(:user, email: email, username: username) }

      context 'with no username specified' do
        let(:email) {'hanzLnGretl12@yahoo.com'}
        let(:username) { nil }

        it 'creates a default username from email, if no username specified' do

          expect(user).to be_valid
          expect(user.username).to eq('hanzLnGretl12')
        end
      end

      context 'with username specified' do
        let(:email) {'hanzLnGretl12@yahoo.com'}
        let(:username) { 'somethingElse~' }
        let(:new_username) { 'somethingNew999' }

        let(:call) { user.update(username: new_username) }

        it 'can be created/updated' do

          expect(user).to be_valid
          expect(user.username).to eq(username)

          call

          expect(user.username).to eq(new_username)
        end
      end
    end
  end

  describe 'user_roles' do
    context 'when a user is created WITHOUT user_role' do
      let(:user) { Fabricate.build(:user, user_role: user_role) }

      before { user.save }

      let(:user_role) { nil }

      it 'should return default :user status' do
        expect(user.user_role).to eq('user')
      end
    end

    context 'when a user is created WITH a user_role specified' do
      let(:user_role1) { Fabricate(:user, user_role: 'user') }
      let(:user_role2) { Fabricate(:user, user_role: 'worker') }
      let(:user_role3) { Fabricate(:user, user_role: 'manager') }
      let(:user_role4) { Fabricate(:user, user_role: 'owner') }
      let(:user_role5) { Fabricate(:user, user_role: 'admin') }

      it { expect(user_role1).to be_valid }
      it { expect(user_role1.role?).to eq('user') }

      it { expect(user_role2).to be_valid }
      it { expect(user_role2.role?).to eq('worker') }

      it { expect(user_role3).to be_valid }
      it { expect(user_role3.role?).to eq('manager') }

      it { expect(user_role4).to be_valid }
      it { expect(user_role4.role?).to eq('owner') }

      it { expect(user_role5).to be_valid }
      it { expect(user_role5.role?).to eq('admin') }

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
