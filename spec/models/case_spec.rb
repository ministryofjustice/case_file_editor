RSpec.describe Case do
  describe 'domestic_violence?' do
    it 'is true if there is a DV case marker' do
      subject.case_markers << 'DV'
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
end
