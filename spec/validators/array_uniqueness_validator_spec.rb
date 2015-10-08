RSpec.describe ArrayUniquenessValidator do
  let(:klass) {
    Class.new do
      include BasicModel

      def self.model_name
        ActiveModel::Name.new(self, nil, 'thing')
      end

      attribute :wotsit, Array[String]
      validates :wotsit,
        array_uniqueness: true
    end
  }

  subject { klass.new }

  it 'passes validation if all attributes are unique' do
    subject.wotsit = ['This is OK', 'This is also OK']
    expect(subject).to be_valid
  end

  it 'passes validation if the array is empty' do
    subject.wotsit = []
    expect(subject).to be_valid
  end

  it 'fails validation if an attribute is repeated' do
    subject.wotsit = ['This is OK', 'This is bad', 'This is bad']
    expect(subject).not_to be_valid
  end
end
