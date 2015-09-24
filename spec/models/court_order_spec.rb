RSpec.describe CourtOrder do
  describe 'court_order_title_needed?' do
    it 'is true if court_order_title is other' do
      subject.court_order_title = 'other'
      expect(subject).to be_court_order_title_needed
    end

    it 'is false if court_order_title is not other' do
      subject.court_order_title = 'dog_control_order'
      expect(subject).not_to be_court_order_title_needed
    end
  end
end
