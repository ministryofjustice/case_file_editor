RSpec.describe BooleanPresenceValidator do
  let(:klass) {
    Class.new do
      include Virtus.model
      include ActiveModel::Validations

      def self.model_name
        ActiveModel::Name.new(self, nil, 'thing')
      end

      attribute :wotsit, Virtus::Attribute::Boolean
      validates :wotsit,
        boolean_presence: true
    end
  }

  subject { klass.new }

  it 'passes validation if attribute is true' do
    subject.wotsit = true
    expect(subject).to be_valid
  end

  it 'passes validation if attribute is false' do
    subject.wotsit = false
    expect(subject).to be_valid
  end

  it 'fails validation if attribute is nil' do
    subject.wotsit = nil
    expect(subject).not_to be_valid
  end
end
