RSpec.describe CaseFile do
  describe 'not_guilty_anticipated_plea?' do
    it 'is true if there is a defendant with a not guilty anticipated plea' do
      subject.defendants << double(not_guilty_anticipated_plea?: true)
      subject.defendants << double(not_guilty_anticipated_plea?: false)
      expect(subject).to be_not_guilty_anticipated_plea
    end

    it 'is false if all defendants have guilty anticipated plea' do
      subject.defendants << double(not_guilty_anticipated_plea?: false)
      expect(subject).not_to be_not_guilty_anticipated_plea
    end
  end

  describe 'young_witness?' do
    it 'is true if any witness is 10 or under' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(2005, 10, 10)
      subject.witnesses = [
        StatementWitness.new(date_of_birth: dob)
      ]
      expect(subject).to be_young_witness
    end

    it 'is false if no witness is 10 or under' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(2000, 10, 10)
      subject.witnesses = [
        StatementWitness.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_young_witness
    end

    it 'is false if date is not set' do
      subject.date = nil
      dob = Date.new(2005, 10, 10)
      subject.witnesses = [
        StatementWitness.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_young_witness
    end
  end

  describe 'older_victim?' do
    it 'is true if any victim is 60 or over' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(1955, 2, 3)
      subject.witnesses = [
        PersonVictim.new(date_of_birth: dob)
      ]
      expect(subject).to be_older_victim
    end

    it 'is false if no witness is 60 or over' do
      subject.date = Date.new(2015, 2, 3)
      dob = Date.new(1965, 2, 3)
      subject.witnesses = [
        PersonVictim.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_older_victim
    end

    it 'is false if date is not set' do
      subject.date = nil
      dob = Date.new(1955, 2, 3)
      subject.witnesses = [
        PersonVictim.new(date_of_birth: dob)
      ]
      expect(subject).not_to be_young_witness
    end
  end
end
