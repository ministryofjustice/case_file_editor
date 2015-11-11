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
      subject.witnesses << StatementWitness.new(date_of_birth: dob)
      expect(subject).to be_young_witness
    end

    it 'is false if no witness is 10 or under' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(2000, 10, 10)
      subject.witnesses << StatementWitness.new(date_of_birth: dob)
      expect(subject).not_to be_young_witness
    end

    it 'is false if date is not set' do
      subject.date = nil
      dob = Date.new(2005, 10, 10)
      subject.witnesses << StatementWitness.new(date_of_birth: dob)
      expect(subject).not_to be_young_witness
    end
  end

  describe 'older_victim?' do
    it 'is true if any victim is 60 or over' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(1955, 2, 3)
      subject.witnesses << PersonVictim.new(date_of_birth: dob)
      expect(subject).to be_older_victim
    end

    it 'is false if no witness is 60 or over' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(1965, 2, 3)
      subject.witnesses << PersonVictim.new(date_of_birth: dob)
      expect(subject).not_to be_older_victim
    end

    it 'is false if date is not set' do
      subject.date = nil
      dob = Date.new(1955, 2, 3)
      subject.witnesses << PersonVictim.new(date_of_birth: dob)
      expect(subject).not_to be_young_witness
    end
  end

  context 'whole-file validations' do
    context 'compensation_applications' do
      let(:compensation_application_a) {
        CompensationApplication.new(
          defendant_names: [
            PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
          ]
        )
      }

      let(:compensation_application_b) {
        CompensationApplication.new(
          defendant_names: [
            PersonName.new(surname: 'Doe', given_name: %w[ Jane ])
          ]
        )
      }

      subject {
        described_class.new(
          defendants: [
            Defendant.new(
              name: PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
            )
          ],
          witnesses: [
            PersonVictim.new(
              compensation_applications: [
                compensation_application_a,
                compensation_application_b
              ]
            )
          ]
        )
      }

      before do
        subject.validate
      end

      it 'is valid when the defendant_names matches a defendant' do
        expect(compensation_application_a.errors[:defendant_names]).to be_empty
      end

      it 'is invalid when the defendant_names does not match a defendant' do
        expect(compensation_application_b.errors[:defendant_names]).not_to be_empty
      end
    end

    context 'offences' do
      let(:generic_offence) { GenericOffence.new }
      let(:retail_theft_offence) { RetailTheftOffence.new }
      let(:assault_offence) { AssaultOffence.new }

      subject {
        described_class.new(
          defendants: [
            Defendant.new(
              offences: [
                GenericOffenceCollection.new(
                  generic_offences: [generic_offence]
                ),
                RetailTheftOffenceCollection.new(
                  retail_theft_offences: [retail_theft_offence]
                ),
                AssaultOffenceCollection.new(
                  assault_offences: [assault_offence]
                )
              ]
            )
          ]
        )
      }

      before do
        allow(subject).to receive(:domestic_violence?).and_return(true)
      end

      it 'validates each offence' do
        expect(generic_offence).
          to receive(:validate_domestic_violence_specific).with(true)
        expect(retail_theft_offence).
          to receive(:validate_domestic_violence_specific).with(true)
        expect(assault_offence).
          to receive(:validate_domestic_violence_specific).with(true)
        subject.validate
      end

      context 'generic offences' do
        it 'is valid if every ID refers to a piece of property' do
          subject.property = [
            Property.new(property_id: 'ABC123'),
            Property.new(property_id: 'ABC124')
          ]
          generic_offence.property_ids = %w[ABC123 ABC124]
          subject.validate
          expect(generic_offence.errors[:property_ids]).to be_empty
        end

        it 'is invalid if an ID does not refer to a piece of property' do
          subject.property = [
            Property.new(property_id: 'ABC123'),
            Property.new(property_id: 'ABC124')
          ]
          generic_offence.property_ids = %w[ABC123 XYZ999]
          subject.validate
          expect(generic_offence.errors[:property_ids]).not_to be_empty
        end
      end

      context 'retail theft offences' do
        it 'is valid if every ID refers to a piece of property' do
          subject.property = [
            Property.new(property_id: 'ABC123'),
            Property.new(property_id: 'ABC124')
          ]
          retail_theft_offence.property_ids = %w[ABC123 ABC124]
          subject.validate
          expect(retail_theft_offence.errors[:property_ids]).to be_empty
        end

        it 'is invalid if an ID does not refer to a piece of property' do
          subject.property = [
            Property.new(property_id: 'ABC123'),
            Property.new(property_id: 'ABC124')
          ]
          retail_theft_offence.property_ids = %w[ABC123 XYZ999]
          subject.validate
          expect(retail_theft_offence.errors[:property_ids]).not_to be_empty
        end
      end
    end

    context 'defendants' do
      let(:defendant) { Defendant.new }
      subject { described_class.new(defendants: [defendant]) }

      before do
        allow(subject).to receive(:domestic_violence?).and_return(true)
      end

      it 'validates each defendant' do
        expect(defendant).
          to receive(:validate_domestic_violence_specific).with(true)
        subject.validate
      end
    end

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

      it 'validates that recorded responses refer to Mme' do
        defendant = Defendant.new
        subject.defendants << defendant
        response_a = MmeRecordedResponse.new(id: 'ABC123')
        response_b = MmeRecordedResponse.new(id: 'XYZ999')
        defendant.multimedia_evidence_response = [response_a, response_b]
        subject.validate

        expect(response_a.errors[:id]).to be_empty
        expect(response_b.errors[:id]).not_to be_empty
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

      it 'validates each witness for GAP case' do
        allow(subject).to receive(:not_guilty_anticipated_plea?).and_return(false)
        expect(witness_a).to receive(:validate_as_gap)
        expect(witness_a).not_to receive(:validate_as_ngap)
        subject.validate
      end

      it 'validates each witness for NGAP case' do
        allow(subject).to receive(:not_guilty_anticipated_plea?).and_return(true)
        expect(witness_a).to receive(:validate_as_ngap)
        expect(witness_a).not_to receive(:validate_as_gap)
        subject.validate
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

    context 'domestic_violence' do
      let(:victim) {
        PersonVictim.new(
          name: PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
        )
      }

      let(:defendant) {
        Defendant.new(domestic_violence: [domestic_violence])
      }

      let(:domestic_violence) { DomesticViolence.new }

      subject {
        described_class.new(
          defendants: [defendant],
          witnesses: [victim]
        )
      }

      it 'is valid if the victim name matches a victim' do
        domestic_violence.victim_name =
          PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
        subject.validate
        expect(domestic_violence.errors[:victim_name]).to be_empty
      end

      it 'is invalid if the victim name does not match a victim' do
        domestic_violence.victim_name =
          PersonName.new(surname: 'Jones', given_name: %w[ Bob ])
        subject.validate
        expect(domestic_violence.errors[:victim_name]).not_to be_empty
      end
    end
  end
end
