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

  describe 'anticipated_guilty_plea?' do
    it 'is true if there is a defendant with a guilty anticipated plea' do
      subject.defendants << double(anticipated_guilty_plea?: true)
      expect(subject).to be_anticipated_guilty_plea
    end

    it 'is false if there is no defendant with a guilty anticipated plea' do
      subject.defendants << double(anticipated_guilty_plea?: false)
      expect(subject).not_to be_anticipated_guilty_plea
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
    end
  end
end
