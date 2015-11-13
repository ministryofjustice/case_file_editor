RSpec.describe NameImporter do
  subject {
    described_class.importer(source).import
  }

  context 'when the object is a person name' do
    let(:source) {
      {
        'type' => 'PersonName',
        'given_name' => %w[ Jennie Claire ],
        'surname' => 'Jones'
      }
    }

    it { is_expected.to be_kind_of(PersonName) }

    it 'has given_name' do
      expect(subject.given_name).to eq(%w[ Jennie Claire ])
    end

    it 'has surname' do
      expect(subject.surname).to eq('Jones')
    end
  end

  context 'when the object is a officer name' do
    let(:source) {
      {
        'type' => 'OfficerName',
        'given_name' => %w[ Jennie Claire ],
        'surname' => 'Jones',
	'rank' => 'Sergeant',
	'collar_number' => 'AA11'
      }
    }

    it { is_expected.to be_kind_of(OfficerName) }

    it 'has given_name' do
      expect(subject.given_name).to eq(%w[ Jennie Claire ])
    end

    it 'has surname' do
      expect(subject.surname).to eq('Jones')
    end
    it 'has rank' do
      expect(subject.rank).to eq('Sergeant')
    end
    it 'has collar number' do
      expect(subject.collar_number).to eq('AA11')
    end
  end

  context 'when the object is an organisation name' do
    let(:source) {
      {
        'type' => 'OrganisationName',
        'organisation_name' => 'ACME, Inc.'
      }
    }

    it { is_expected.to be_kind_of(OrganisationName) }

    it 'has organisation_name' do
      expect(subject.organisation_name).to eq('ACME, Inc.')
    end
  end
end
