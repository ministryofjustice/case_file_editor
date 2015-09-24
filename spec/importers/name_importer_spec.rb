RSpec.describe NameImporter do
  subject {
    described_class.importer(source).import
  }

  context 'when the object is a person name' do
    let(:source) {
      {
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

  context 'when the object is an organisation name' do
    let(:source) {
      {
        'organisation_name' => 'ACME, Inc.'
      }
    }

    it { is_expected.to be_kind_of(OrganisationName) }

    it 'has organisation_name' do
      expect(subject.organisation_name).to eq('ACME, Inc.')
    end
  end
end
