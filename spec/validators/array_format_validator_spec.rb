RSpec.describe ArrayFormatValidator do
  let(:klass) {
    Class.new do
      include Virtus.model
      include ActiveModel::Validations

      def self.model_name
        ActiveModel::Name.new(self, nil, 'thing')
      end

      attribute :wotsit, Array[String]
      validates :wotsit,
        array_format: { with: /OK/ }
    end
  }

  subject { klass.new }

  it 'passes validation if all attributes match the format' do
    subject.wotsit = ['This is OK', 'This is also OK']
    expect(subject).to be_valid
  end

  it 'passes validation if the array is empty' do
    subject.wotsit = []
    expect(subject).to be_valid
  end

  it 'fails validation if an attribute does not match the format' do
    subject.wotsit = ['This is OK', 'This is bad']
    expect(subject).not_to be_valid
  end

  it 'fails validation if an attribute is nil' do
    subject.wotsit = ['This is OK', nil]
    expect(subject).not_to be_valid
  end
end
