RSpec.describe Injury do
  subject { described_class.new }

  describe 'images_provided?' do
    it 'is true if there is a description' do
      subject.image_description = 'blah'
      expect(subject).to be_images_provided
    end

    it 'is true if there is at least one image url' do
      subject.image_urls = %w[ http://example.com ]
      expect(subject).to be_images_provided
    end

    it 'is false if there is no description and no image urls' do
      expect(subject).not_to be_images_provided
    end
  end
end
