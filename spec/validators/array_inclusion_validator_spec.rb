RSpec.describe ArrayInclusionValidator do
  let(:klass) {
    Class.new do
      include Virtus.model
      include ActiveModel::Validations

      def self.model_name
        ActiveModel::Name.new(self, nil, 'thing')
      end

      attribute :wotsit, Array[String]
      validates :wotsit,
        array_inclusion: { in: ['OK', 'Also fine'] }
    end
  }

  subject { klass.new }

  it 'passes validation if all attributes are in the acceptable list' do
    subject.wotsit = %w[ OK ]
    expect(subject).to be_valid
  end

  it 'passes validation if the array is empty' do
    subject.wotsit = []
    expect(subject).to be_valid
  end

  it 'fails validation if an attribute is not in the acceptable list' do
    subject.wotsit = %w[ OK bad ]
    expect(subject).not_to be_valid
  end
end
