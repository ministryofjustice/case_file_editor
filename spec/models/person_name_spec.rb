RSpec.describe PersonName do
  subject {
    described_class.new(
      surname: 'Smith',
      given_name: %w[ Alan Brian ]
    )
  }

  let(:doppelgaenger) {
    described_class.new(
      surname: 'Smith',
      given_name: %w[ Alan Brian ]
    )
  }

  it { is_expected.to eq(doppelgaenger) }

  it 'is equivalent to another for the purposes of array arithmetic' do
    expect([subject] - [doppelgaenger]).to be_empty
  end
end
