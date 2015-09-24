RSpec.describe Defendant do
  subject { described_class.new }

  describe 'initiated_as_charge?' do
    it 'is true if initiation_type is charge' do
      subject.initiation_type = 'charge'
      expect(subject).to be_initiated_as_charge
    end

    it 'is false if initiation_type is not charge' do
      expect(subject).not_to be_initiated_as_charge
    end
  end

  describe 'initiated_as_requisition?' do
    it 'is true if initiation_type is requisition' do
      subject.initiation_type = 'requisition'
      expect(subject).to be_initiated_as_requisition
    end

    it 'is false if initiation_type is not requisition' do
      expect(subject).not_to be_initiated_as_requisition
    end
  end

  describe 'conditional_bail?' do
    it 'is true if person_remand_status is conditional_bail' do
      subject.person_remand_status = 'conditional_bail'
      expect(subject).to be_conditional_bail
    end

    it 'is false if person_remand_status is not conditional_bail' do
      expect(subject).not_to be_conditional_bail
    end
  end

  describe 'unconditional_bail?' do
    it 'is true if person_remand_status is unconditional_bail' do
      subject.person_remand_status = 'unconditional_bail'
      expect(subject).to be_unconditional_bail
    end

    it 'is false if person_remand_status is not unconditional_bail' do
      expect(subject).not_to be_unconditional_bail
    end
  end

  describe 'breach_order_title_needed?' do
    it 'is true if breach_order_title is other' do
      subject.breach_order_title = 'other'
      expect(subject).to be_breach_order_title_needed
    end

    it 'is false if breach_order_title is not other' do
      subject.breach_order_title = 'dog_control_order'
      expect(subject).not_to be_breach_order_title_needed
    end
  end

  describe 'mme_recorded_responses_present?' do
    it 'is true if there are responses' do
      subject.multimedia_evidence_recorded_responses <<
        MmeRecordedResponse.new
      expect(subject).to be_mme_recorded_responses_present
    end

    it 'is false if there are no responses' do
      expect(subject).not_to be_mme_recorded_responses_present
    end
  end
end
