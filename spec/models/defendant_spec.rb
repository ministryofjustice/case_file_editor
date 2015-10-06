RSpec.describe Defendant do
  describe 'initiated_as_charge?' do
    it 'is true if initiation_type is charge' do
      subject.initiation_type = 'charge'
      expect(subject).to be_initiated_as_charge
    end

    it 'is false if initiation_type is not charge' do
      expect(subject).not_to be_initiated_as_charge
    end
  end

  describe 'initiated_as_requisition?' do
    it 'is true if initiation_type is requisition' do
      subject.initiation_type = 'requisition'
      expect(subject).to be_initiated_as_requisition
    end

    it 'is false if initiation_type is not requisition' do
      expect(subject).not_to be_initiated_as_requisition
    end
  end

  describe 'conditional_bail?' do
    it 'is true if person_remand_status is conditional_bail' do
      subject.person_remand_status = 'conditional_bail'
      expect(subject).to be_conditional_bail
    end

    it 'is false if person_remand_status is not conditional_bail' do
      expect(subject).not_to be_conditional_bail
    end
  end

  describe 'unconditional_bail?' do
    it 'is true if person_remand_status is unconditional_bail' do
      subject.person_remand_status = 'unconditional_bail'
      expect(subject).to be_unconditional_bail
    end

    it 'is false if person_remand_status is not unconditional_bail' do
      expect(subject).not_to be_unconditional_bail
    end
  end

  describe 'breach_order_title_needed?' do
    it 'is true if breach_order_title is other' do
      subject.breach_order_title = 'other'
      expect(subject).to be_breach_order_title_needed
    end

    it 'is false if breach_order_title is not other' do
      subject.breach_order_title = 'dog_control_order'
      expect(subject).not_to be_breach_order_title_needed
    end
  end

  describe 'anticipated_guilty_plea?' do
    it 'is true if there is an offence collection with a guilty anticipated plea' do
      subject.offences << double(anticipated_guilty_plea?: true)
      expect(subject).to be_anticipated_guilty_plea
    end

    it 'is false if there is no offence collection with a guilty anticipated plea' do
      subject.offences << double(anticipated_guilty_plea?: false)
      expect(subject).not_to be_anticipated_guilty_plea
    end
  end

  context 'validations' do
    let(:today) { Date.new(2015, 1, 1) }

    before do
      subject.date_of_birth = date_of_birth
    end

    describe 'parent_guardian_copy' do
      context 'when over 18' do
        let(:date_of_birth) { Date.new(1980, 1, 1) }

        it 'is invalid if present' do
          subject.parent_guardian_copy = false
          subject.validate_by_age(today)
          expect(subject.errors[:parent_guardian_copy]).not_to be_empty
        end

        it 'is valid if nil' do
          subject.parent_guardian_copy = nil
          subject.validate_by_age(today)
          expect(subject.errors[:parent_guardian_copy]).to be_empty
        end
      end

      context 'when under 18' do
        let(:date_of_birth) { Date.new(2000, 1, 1) }

        it 'is valid if present' do
          subject.parent_guardian_copy = false
          subject.validate_by_age(today)
          expect(subject.errors[:parent_guardian_copy]).to be_empty
        end

        it 'is invalid if nil' do
          subject.parent_guardian_copy = nil
          subject.validate_by_age(today)
          expect(subject.errors[:parent_guardian_copy]).not_to be_empty
        end
      end
    end
  end
end
