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

  describe 'young_witness?' do
    it 'is true if any witness is 10 or under' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(2005, 10, 10)
      subject.witnesses << StatementWitness.new(date_of_birth: dob)
      expect(subject).to be_young_witness
    end

    it 'is false if no witness is 10 or under' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(2000, 10, 10)
      subject.witnesses << StatementWitness.new(date_of_birth: dob)
      expect(subject).not_to be_young_witness
    end

    it 'is false if date is not set' do
      subject.date = nil
      dob = Date.new(2005, 10, 10)
      subject.witnesses << StatementWitness.new(date_of_birth: dob)
      expect(subject).not_to be_young_witness
    end
  end
end
