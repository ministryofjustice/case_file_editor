RSpec.describe FirstHearingCaseFile do
  describe 'domestic_violence_case?' do
    it 'is true if there is a DV case marker' do
      subject.case_markers << 'DomesticViolence'
      expect(subject).to be_domestic_violence_case
    end

    it 'is false if there is no DV case marker' do
      expect(subject).not_to be_domestic_violence_case
    end
  end
end
