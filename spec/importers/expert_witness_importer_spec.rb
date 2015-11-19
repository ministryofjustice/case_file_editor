RSpec.describe ExpertWitnessImporter do
  let(:source) {
    {
      'type' => 'ExpertWitness',
      'witness_type' => ['expert'],
      'name' => name,
      'witness' => {
        'nature_of_involvement' => 'Nature of involvement',
        'evidence_they_can_give' => 'Evidence they can give'
      }
    }
  }

  context 'imported object' do
    subject {
      described_class.new(source).import
    }

    context 'with person name' do
      let(:name) {
        {
          'type' => 'PersonName',
          'given_name' => %w[ Jennie Claire ],
          'surname' => 'Jones'
        }
      }

      it { is_expected.to be_kind_of(ExpertWitness) }

      it 'has top-level properties' do
        expect(subject.witness_type).to eq(['expert'])
      end

      it 'has properties from the witness sub-object' do
        expect(subject.nature_of_involvement).to eq('Nature of involvement')
      end

      context 'name' do
        subject { super().name }

        it { is_expected.to be_kind_of(PersonName) }

        it 'has given_name' do
          expect(subject.given_name).to eq(%w[ Jennie Claire ])
        end

        it 'has surname' do
          expect(subject.surname).to eq('Jones')
        end
      end
    end

    context 'with organisation name' do
      let(:name) {
        {
          'type' => 'OrganisationName',
          'organisation_name' => 'ACME, Inc.'
        }
      }

      context 'name' do
        subject { super().name }

        it { is_expected.to be_kind_of(OrganisationName) }

        it 'has organisation_name' do
          expect(subject.organisation_name).to eq('ACME, Inc.')
        end
      end
    end
  end
end
