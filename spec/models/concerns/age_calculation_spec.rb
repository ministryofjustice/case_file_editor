RSpec.describe AgeCalculation do
  let(:klass) {
    Class.new do
      include Virtus.model
      include AgeCalculation

      attribute :date_of_birth, Date
    end
  }

  subject { klass.new }

  describe 'age' do
    it 'calculates relative to given date' do
      subject.date_of_birth = Date.new(2000, 1, 2)
      today = Date.new(2015, 1, 2)
      expect(subject.age(today)).to eq(15)
    end

    it 'is nil if date_of_birth is nil' do
      subject.date_of_birth = nil
      today = Date.new(2015, 1, 2)
      expect(subject.age(today)).to be_nil
    end
  end
end
