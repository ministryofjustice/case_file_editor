RSpec.describe FalsehoodValidator do
  let(:klass) {
    Class.new do
      include BasicModel

      def self.model_name
        ActiveModel::Name.new(self, nil, 'thing')
      end

      attribute :wotsit, Virtus::Attribute::Boolean
      validates :wotsit, falsehood: true
    end
  }

  subject { klass.new }

  it 'fails validation if attribute is true' do
    subject.wotsit = true
    expect(subject).not_to be_valid
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
