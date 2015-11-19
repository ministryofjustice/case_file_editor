RSpec.describe Case do
  describe 'domestic_violence?' do
    it 'is true if there is a DV case marker' do
      subject.case_markers << 'DomesticViolence'
      expect(subject).to be_domestic_violence
    end

    it 'is false if there is no DV case marker' do
      expect(subject).not_to be_domestic_violence
    end
  end

  describe 'not_guilty_anticipated_plea?' do
    it 'is true if there is a defendant with a not guilty anticipated plea' do
      subject.defendants << double(not_guilty_anticipated_plea?: true)
      subject.defendants << double(not_guilty_anticipated_plea?: false)
      expect(subject).to be_not_guilty_anticipated_plea
    end

    it 'is false if all defendants have guilty anticipated plea' do
      subject.defendants << double(not_guilty_anticipated_plea?: false)
      expect(subject).not_to be_not_guilty_anticipated_plea
    end
  end

  describe 'young_witness?' do
    it 'is true if any witness is 10 or under' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(2005, 10, 10)
      subject.witnesses = [
        StatementWitness.new(date_of_birth: dob)
      ]
      expect(subject).to be_young_witness
    end

    it 'is false if no witness is 10 or under' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(2000, 10, 10)
      subject.witnesses = [
        StatementWitness.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_young_witness
    end

    it 'is false if date is not set' do
      subject.date = nil
      dob = Date.new(2005, 10, 10)
      subject.witnesses = [
        StatementWitness.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_young_witness
    end
  end

  describe 'older_victim?' do
    it 'is true if any victim is 60 or over' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(1955, 2, 3)
      subject.witnesses = [
        PersonVictim.new(date_of_birth: dob)
      ]
      expect(subject).to be_older_victim
    end

    it 'is false if no witness is 60 or over' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(1965, 2, 3)
      subject.witnesses = [
        PersonVictim.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_older_victim
    end

    it 'is false if date is not set' do
      subject.date = nil
      dob = Date.new(1955, 2, 3)
      subject.witnesses = [
        PersonVictim.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_young_witness
    end
  end

  context 'whole-file validations' do
    context 'multimedia_evidence' do
      let(:mme_a) { Mme.new(id: 'ABC123') }
      let(:mme_b) { Mme.new(id: 'ABC123') }
      let(:mme_c) { Mme.new(id: 'ABC124') }
      subject {
        described_class.new(multimedia_evidence: [mme_a, mme_b, mme_c])
      }

      it 'validates multimedia_evidence id uniqueness' do
        subject.validate
        expect(mme_a.errors[:id]).not_to be_empty
        expect(mme_b.errors[:id]).not_to be_empty
        expect(mme_c.errors[:id]).to be_empty
      end
    end

    context 'witnesses' do
      let(:witness_a) { StatementWitness.new(witness_id: 'ABC123') }
      let(:witness_b) { StatementWitness.new(witness_id: 'ABC123') }
      let(:witness_c) { StatementWitness.new(witness_id: 'ABC124') }
      subject {
        described_class.new(witnesses: [witness_a, witness_b, witness_c])
      }

      it 'validates multimedia_evidence id uniqueness' do
        subject.validate
        expect(witness_a.errors[:witness_id]).not_to be_empty
        expect(witness_b.errors[:witness_id]).not_to be_empty
        expect(witness_c.errors[:witness_id]).to be_empty
      end
    end

    context 'property' do
      let(:property_a) { Property.new(property_id: 'ABC123') }
      let(:property_b) { Property.new(property_id: 'ABC123') }
      let(:property_c) { Property.new(property_id: 'ABC124') }
      subject {
        described_class.new(property: [property_a, property_b, property_c])
      }

      it 'validates multimedia_evidence id uniqueness' do
        subject.validate
        expect(property_a.errors[:property_id]).not_to be_empty
        expect(property_b.errors[:property_id]).not_to be_empty
        expect(property_c.errors[:property_id]).to be_empty
      end
    end
  end
end
