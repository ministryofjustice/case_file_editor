RSpec.describe RetailTheftOffenceCollection do
  describe 'anticipated_guilty_plea?' do
    it 'is true if there is an offence with a guilty anticipated plea' do
      subject.retail_theft_offences << double(anticipated_guilty_plea?: true)
    end

    it 'is false if there is no offence with a guilty anticipated plea' do
      subject.retail_theft_offences << double(anticipated_guilty_plea?: false)
      expect(subject).not_to be_anticipated_guilty_plea
    end
  end
end
