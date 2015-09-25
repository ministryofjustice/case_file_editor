RSpec.describe ArrayMembershipValidator do
  let(:klass) {
    Class.new do
      include Virtus.model
      include ActiveModel::Validations

      def self.model_name
        ActiveModel::Name.new(self, nil, 'thing')
      end

      attribute :wotsit, Array[String]
      validates :wotsit,
        array_membership: { of: 'foo' }
    end
  }

  subject { klass.new }

  it 'passes validation if the required item is present' do
    subject.wotsit = %w[ a b c foo d ]
    expect(subject).to be_valid
  end

  it 'fails validation if the array is empty' do
    subject.wotsit = []
    expect(subject).not_to be_valid
  end

  it 'fails validation if the required item is absent' do
    subject.wotsit = %w[ a b c d ]
    expect(subject).not_to be_valid
  end
end
