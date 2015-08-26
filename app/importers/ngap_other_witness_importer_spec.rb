require 'rails_helper'

RSpec.describe NgapOtherWitnessImporter do
  let(:source) {
    {
      'type' => 'NgapOtherWitness',
      'witness_type' => %w[ eye ],
      'name' => {
        'given_name' => %w[ Jennie Claire ],
        'surname' => 'Jones'
      },
      'witness' => {
        'nature_of_involvement' => 'Nature of involvement',
        'evidence_they_can_give' => 'Evidence they can give'
      },
      'number' => 'ABC123',
      'rank' => 'Sergeant'
    }
  }

  context 'imported object' do
    subject {
      described_class.new(source).import
    }

    it { is_expected.to be_kind_of(NgapOtherWitness) }

    it 'has top-level properties' do
      expect(subject.number).to eq('ABC123')
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
end
