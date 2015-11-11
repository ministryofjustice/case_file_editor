RSpec.describe RetailTheftOffenceCollection do
  describe 'not_guilty_anticipated_plea?' do
    it 'is true if there is an offence with a not guilty anticipated plea' do
      subject.retail_theft_offences << double(not_guilty_anticipated_plea?: true)
      subject.retail_theft_offences << double(not_guilty_anticipated_plea?: false)
      expect(subject).to be_not_guilty_anticipated_plea
    end

    it 'is false if there is no offence with a guilty anticipated plea' do
      subject.retail_theft_offences << double(not_guilty_anticipated_plea?: false)
      expect(subject).not_to be_not_guilty_anticipated_plea
    end
  end
end
