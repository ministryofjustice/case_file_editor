RSpec.describe StatementWitness do
  context 'validations' do
    describe 'rank' do
      context 'for an officer' do
        before do
          subject.witness_type << 'arresting_officer'
        end

        it 'is valid if present' do
          subject.rank = 'Corporal'
          subject.validate
          expect(subject.errors[:rank]).to be_empty
        end

        it 'is invalid if absent' do
          subject.validate
          expect(subject.errors[:rank]).not_to be_empty
        end
      end

      context 'for another witness type' do
        before do
          subject.witness_type << 'child'
        end

        it 'is invalid if present' do
          subject.rank = 'Corporal'
          subject.validate
          expect(subject.errors[:rank]).not_to be_empty
        end

        it 'is valid if absent' do
          subject.validate
          expect(subject.errors[:rank]).to be_empty
        end
      end
    end
  end
end
