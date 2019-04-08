require 'rails_helper'

RSpec.describe ShiftResponsibility, type: :model do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:shift_id) }
    it { expect(subject).to validate_presence_of(:responsibility_id) }
    it { expect(subject).to_not validate_presence_of(:user_id) }
  end
  describe 'creation' do
    let(:shift) { Fabricate(:shift_responsibility) }

    it { expect(shift).to be_valid }

    it { expect(shift.name).to eq(shift.responsibility.name) }

    context 'with and without name assignation on create' do
      let(:shift_with_name) { Fabricate(:shift_responsibility, name: name ) }

      context 'with name assigned' do
        let(:name) { 'Barista' }
        it 'will raise error if given name' do
          expect { shift_with_name }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'without name assigned' do
        let(:name) { nil }
        it 'will raise error if given name' do
          expect { shift_with_name }.to_not raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
  describe 'shift assignation' do
    let!(:shift) { Fabricate(:shift_with_responsibilities) }
    let(:user) { Fabricate(:user, user_role: 0, email: 'user@place.com') }
    let(:worker) { Fabricate(:user, user_role: 1, email: 'worker@place.com') }
    let(:manager) { Fabricate(:user, user_role: 2, email: 'manager@place.com') }
    let(:owner) { Fabricate(:user, user_role: 3, email: 'owner@place.com') }
    let(:admin) { Fabricate(:user, user_role: 4, email: 'admin@otherplace.com') }

    let(:responsibility) { shift.shifts.first }

    let(:assign_user) { shift.assign_shift(user, responsibility, 'Barista') }
    let(:assign_worker) { shift.assign_shift(worker, responsibility, 'Barista') }
    let(:assign_manager) { shift.assign_shift(manager, responsibility, 'Barista') }
    let(:assign_owner) { shift.assign_shift(owner, responsibility, 'Barista') }
    let(:assign_admin) { shift.assign_shift(admin, responsibility, 'Barista') }

    it 'must go to a worker or manager' do
      expect(assign_user).to eq(false)
      expect(assign_owner).to eq(false)
      expect(assign_admin).to eq(false)

      expect(assign_worker).to eq(true)
      expect(assign_manager).to eq(true)
    end

    it 'requires a responsibility OR a shift' do
      expect { shift.assign_shift(worker, responsibility) }.to_not raise_error(ArgumentError)
      expect { shift.assign_shift(worker, nil, 'Barista') }.to_not raise_error(ArgumentError)
      expect { shift.assign_shift(worker) }.to raise_error(ArgumentError)
    end

    it 'can be assigned with a responsibility record as an argument' do
      expect(shift.assign_shift(worker, responsibility)).to eq(true)
    end
  end
end
