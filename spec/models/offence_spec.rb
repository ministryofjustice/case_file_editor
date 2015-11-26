RSpec.describe Offence do
  describe 'not_guilty_anticipated_plea?' do
    it 'is false if anticipated plea is guilty' do
      subject.anticipated_plea = 'guilty'
      expect(subject).not_to be_not_guilty_anticipated_plea
    end

    it 'is true if anticipated pleas is not guilty' do
      subject.anticipated_plea = 'not_guilty'
      expect(subject).to be_not_guilty_anticipated_plea
    end
  end

  context 'validations' do
    let!(:case_file) {
      FirstHearingCaseFile.new(
        defendants: [
          Defendant.new(
            offences: [
              GenericOffenceCollection.new(
                generic_offences: [subject]
              )
            ]
          )
        ]
      )
    }

    subject { GenericOffence.new }

    describe 'demeanour_at_incident' do
      context 'when case is DV' do
        before do
          allow(case_file).to receive(:domestic_violence?).and_return(true)
        end

        it 'is DV' do
          expect(subject).to be_domestic_violence
        end

        it 'is invalid if nil' do
          subject.demeanour_at_incident = nil
          subject.validate
          expect(subject.errors[:demeanour_at_incident]).not_to be_empty
        end

        it 'is valid if present' do
          subject.demeanour_at_incident = 'foo'
          subject.validate
          expect(subject.errors[:demeanour_at_incident]).to be_empty
        end
      end

      context 'when case is not DV' do
        before do
          allow(case_file).to receive(:domestic_violence?).and_return(false)
        end

        it 'is not DV' do
          expect(subject).not_to be_domestic_violence
        end

        it 'is invalid if present' do
          subject.demeanour_at_incident = 'foo'
          subject.validate
          expect(subject.errors[:demeanour_at_incident]).not_to be_empty
        end

        it 'is valid if nil' do
          subject.demeanour_at_incident = nil
          subject.validate
          expect(subject.errors[:demeanour_at_incident]).to be_empty
        end
      end
    end

    describe 'property_ids' do
      it 'is valid if every ID refers to a piece of property' do
        case_file.property = [
          Property.new(property_id: 'ABC123'),
          Property.new(property_id: 'ABC124')
        ]
        subject.property_ids = %w[ABC123 ABC124]
        subject.validate
        expect(subject.errors[:property_ids]).to be_empty
      end

      it 'is invalid if an ID does not refer to a piece of property' do
        case_file.property = [
          Property.new(property_id: 'ABC123'),
          Property.new(property_id: 'ABC124')
        ]
        subject.property_ids = %w[ABC123 XYZ999]
        subject.validate
        expect(subject.errors[:property_ids]).not_to be_empty
      end
    end
  end
end
