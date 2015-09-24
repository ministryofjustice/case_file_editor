RSpec.describe OrganisationVictimExporter do
  let(:victim) {
    OrganisationVictim.new(
      witness_type: ['other'],
      name: OrganisationName.new(
        organisation_name: 'ACME, Inc.'
      ),
      nature_of_involvement: 'Nature of involvement',
      evidence_they_can_give: 'Evidence they can give',
      victim_code_requirements_met: true,
      has_the_victim_made_a_vps_isb: false
    )
  }

  context 'exported hash' do
    subject { described_class.new(victim).export }

    it 'includes a type' do
      expect(subject).to include('type' => 'OrganisationVictim')
    end

    it 'includes a name object' do
      expect(subject).to include(
        'name' => { 'organisation_name' => 'ACME, Inc.' }
      )
    end

    context 'victim sub-document' do
      subject { super().fetch('victim') }

      it 'includes victim-specific fields' do
        expect(subject).to include(
          'witness_type' => ['other'],
          'victim_code_requirements_met' => true,
          'has_the_victim_made_a_vps_isb' => false
        )
      end

      context 'witness sub-sub-document' do
        subject { super().fetch('witness') }

        it 'includes witness-specific fields' do
          expect(subject).to eq(
            "nature_of_involvement" => "Nature of involvement",
            "evidence_they_can_give" => "Evidence they can give"
          )
        end
      end
    end
  end
end
